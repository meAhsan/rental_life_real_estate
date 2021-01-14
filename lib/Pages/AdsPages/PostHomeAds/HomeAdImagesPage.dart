import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';

class HomeAdImagesPage extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final RentalLifeUser _rentalLifeUser;
  final GlobalKey<ScaffoldState> globalKey;

  HomeAdImagesPage(this._formKey, this._rentalLifeUser, this.globalKey);

  @override
  _HomeAdImagesPageState createState() => _HomeAdImagesPageState();
}

Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;

class _HomeAdImagesPageState extends State<HomeAdImagesPage>
    with AutomaticKeepAliveClientMixin<HomeAdImagesPage> {
  bool _formChanged = false;
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  int numberOfImages = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Form(
                  key: widget._formKey,
                  child: SizedBox(
                    height: 0,
                    child: TextFormField(
                      initialValue: " ",
                      onSaved: ((val) async {
                        await uploadImages();
                        // updateUserInfo();
                        await writeUpdatedInfoToUserDocument();
                      }),
                      //enabled: false,
                      validator: (val) {
                        print("VAlidating Home ads images sections");
                        if (images.length > 0) {
                          return null;
                        } else {
                          print("Upload some images");
                          return "Upload some images";
                        }
                      },
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: loadAssets,
                    child: ThreeDContainer(
                      width: 130,
                      height: 50,
                      backgroundColor: firstColor,
                      backgroundDarkerColor: firstColor,
                      borderColor: Colors.redAccent,
                      child: Center(
                          child: Text(
                            "Pick images",
                            style: TextStyle(color: secondColor),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: buildGridView(),
              )
            ],
          ),
        ),
      ],
    );
  }


  void writeUpdatedInfoToUserDocument() async {
    // print("In write Updated Info To User Document");
    // print("widget._rentalLifeUser.uid: ${widget._rentalLifeUser.uid}");
    // print(
    //     "widget._rentalLifeUser.adsDocumentId: ${widget._rentalLifeUser
    //         .adsDocumentIdList}");
    // print(
    //     "widget._rentalLifeUser.totalAdsPosted: ${widget._rentalLifeUser
    //         .totalAdsPosted}");


    // await Firestore.instance
    //     .collection('user')
    //     .document(widget._rentalLifeUser.uid)
    //     .updateData(
    //     {'adsDocumentsId': widget._rentalLifeUser.adsDocumentIdList});

    SnackBar snackbar = SnackBar(content: Text('User Profile Updated.'));
    widget.globalKey.currentState.showSnackBar(snackbar);


    setState(() {
      images = [];
      imageUrls = [];
    });

  }

  String getDocuemntName() {
    String adDocumentName = widget._rentalLifeUser.uid;
    String numberOfAds = widget._rentalLifeUser.totalAdsPosted.toString();
    adDocumentName = adDocumentName + numberOfAds;
    return adDocumentName;
  }

  void _onFormChange() {
    setState(() {
      _formChanged = true;
    });
  }

  Future<bool> _onWillPop() {
    if (!_formChanged) return Future<bool>.value(true);
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to abandon the form? Any changes will be lost."),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(false),
                textColor: Colors.black,
              ),
              FlatButton(
                child: Text("Abandon"),
                textColor: Colors.red,
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ) ??
              false;
        });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print(resultList.length);
      print((await resultList[0].getThumbByteData(122, 100)));
      print((await resultList[0].getByteData()));
      print((await resultList[0].metadata));
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(asset.getByteData(quality: 100));
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ThreeDContainer(
            backgroundColor: MultiPickerApp.darker,
            backgroundDarkerColor: MultiPickerApp.darker,
            height: 50,
            width: 50,
            borderDarkerColor: MultiPickerApp.pauseButton,
            borderColor: MultiPickerApp.pauseButtonDarker,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            ),
          ),
        );
      }),
    );
  }

  //Update Firestore document
  void uploadImages() async {
    print("Upload images mehtod");
    for (var imageFile in images) {
      String downloadUrl = await postImage(imageFile);

      imageUrls.add(downloadUrl.toString());
      if (imageUrls.length == images.length) {
        String documnetID =
        getDocuemntName(); //DateTime.now().millisecondsSinceEpoch.toString();
        return await Firestore.instance
            .collection('AdsDocument')
            .document(documnetID)
            .updateData({'ImagesURL': imageUrls});
        SnackBar snackbar = SnackBar(content: Text('Uploaded Successfully'));
        widget.globalKey.currentState.showSnackBar(snackbar);
        setState(() {
          images = [];
          imageUrls = [];
        });
        ;
      }
    }
  }

  //Update Firebase Storage
  Future<dynamic> postImage(Asset imageFile) async {
    String uid = widget._rentalLifeUser.uid;
    // print("UID: $uid");
    String fileName = '${DateTime
        .now()
        .millisecondsSinceEpoch
        .toString()}';
    fileName = "RentalLifeAdsImages/HomeAds/$uid/$fileName";
    print("FIleName: $fileName");
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
    reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }
}

class MultiPickerApp {
  static Color navigateButton = Color(0xff141516);
  static Color pauseButton = Color(0xffF41F00);
  static Color pauseButtonDarker = Color(0xff9B1400);
  static Color background = Color(0xff1E2025);
  static Color brighter = Color(0xff353235);
  static Color darker = Colors.black;
}

class ThreeDContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color backgroundDarkerColor;
  final Color borderColor;
  final Color borderDarkerColor;
  final double spreadRadius;
  final double offset;
  final double blurRadius;

  const ThreeDContainer({
    Key key,
    @required this.child,
    @required this.width,
    @required this.height,
    @required this.backgroundColor,
    @required this.backgroundDarkerColor,
    this.borderColor,
    this.borderDarkerColor,
    this.blurRadius = 15,
    this.spreadRadius = 4,
    this.offset = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(width / 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
              color: MultiPickerApp.darker,
              offset: Offset(offset, offset),
              blurRadius: blurRadius,
              spreadRadius: spreadRadius),
          BoxShadow(
              color: MultiPickerApp.brighter,
              offset: Offset(-offset, -offset),
              blurRadius: blurRadius,
              spreadRadius: spreadRadius),
        ],
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            borderDarkerColor ?? MultiPickerApp.darker,
            borderColor ?? MultiPickerApp.brighter,
          ],
        ),
      ),
      child: Container(
        width: width,
        height: height,
        child: child,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                backgroundDarkerColor,
                backgroundColor,
              ],
            )),
      ),
    );
  }
}
