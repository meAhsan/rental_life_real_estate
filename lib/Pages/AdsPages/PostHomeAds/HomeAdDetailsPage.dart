import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Service%20Classes/FirestoreDatabaseServicesForUser.dart';

class HomeAdDetailsPage extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final RentalLifeUser _rentalLifeUser;

  HomeAdDetailsPage(this._formKey, this._rentalLifeUser);

  @override
  _HomeAdDetailsPageState createState() => _HomeAdDetailsPageState();
}

String adTitle;
// String adDescription;
String adOwnerId;
int adNumberByOwner;
// int numberOfAdImagesUploaded;
//     String adLocation;
String adPostDate;
int adRent;
bool isAdDeactivated = false;
int totalThumbsUp;
int totalRating = 0;
// String adType,
int numberOfRooms;
int numberOfBaths;
int totalNumberOfFloors;
int floorNumber;
double sizeInMarlas;

class _HomeAdDetailsPageState extends State<HomeAdDetailsPage>
    with AutomaticKeepAliveClientMixin<HomeAdDetailsPage> {
  @override
  bool get wantKeepAlive => true;
  bool _formChanged = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Form(
              onChanged: _onFormChange,
              onWillPop: _onWillPop,
              key: widget._formKey,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    onSaved: ((val) async {
                      await updateUserInfo(widget._rentalLifeUser);
                      await storeAdDetailsDataToDocument(
                          widget._rentalLifeUser);
                    }),
                    keyboardType: TextInputType.number,
                    // initialValue: widget._rentalLifeUser.name,//_name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: true,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.meeting_room_sharp,
                        color: Colors.blueGrey,
                      ),
                      labelText: "Number of Rooms ",
                      hintText: "Required",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) {
                      if (val.length > 2 || val.length < 1) {
                        return 'Enter a valid number of rooms';
                      } else if (int.parse(val) == null) {
                        return 'Enter an absolute number only';
                      }
                      return null;
                    }),
                    onChanged: (val) {
                      setState(() {
                        numberOfRooms = int.parse(val);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // initialValue: widget._rentalLifeUser.phoneNum,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    // autofocus: true,
                    decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //     padding: EdgeInsets.all(15), child: Text('+92 ')),
                      suffixIcon: Icon(
                        Icons.bathtub,
                        color: Colors.blueGrey,
                      ),
                      labelText: "Number of Baths ",
                      hintText: "(Required)",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) {
                      if (val.length > 2 || val.length < 1) {
                        return 'Enter a valid number of baths';
                      } else if (int.parse(val) == null) {
                        return 'Enter an absolute number only';
                      }
                      return null;
                    }),
                    onChanged: (val) {
                      setState(() {
                        numberOfBaths = int.parse(val);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // initialValue: widget._rentalLifeUser.phoneNum,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    // autofocus: true,
                    decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //     padding: EdgeInsets.all(15), child: Text('+92 ')),
                      suffixIcon: Icon(
                        Icons.roofing_outlined,
                        color: Colors.blueGrey,
                      ),
                      labelText: "Total floors in building ",
                      hintText: "(Required)",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) {
                      if (val.length > 3 || val.length < 1) {
                        return 'Enter a valid number of floors';
                      } else if (int.parse(val) == null) {
                        return 'Enter an absolute floor number only';
                      }
                      return null;
                    }),
                    onChanged: (val) {
                      setState(() {
                        totalNumberOfFloors = int.parse(val);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // initialValue: widget._rentalLifeUser.phoneNum,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    // autofocus: true,
                    decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //     padding: EdgeInsets.all(15), child: Text('+92 ')),
                      suffixIcon: Icon(
                        Icons.sensor_window_outlined,
                        color: Colors.blueGrey,
                      ),
                      labelText: "Floor for Rent  ",
                      hintText: "(Required)",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) {
                      if (val.length > 2 || val.length < 1) {
                        return 'Enter a valid floor number';
                      } else if (int.parse(val) == null) {
                        return 'Enter an absolute floor number only';
                      }
                      return null;
                    }),
                    onChanged: (val) {
                      setState(() {
                        floorNumber = int.parse(val);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // initialValue: widget._rentalLifeUser.phoneNum,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    // autofocus: true,
                    decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //     padding: EdgeInsets.all(15), child: Text('+92 ')),
                      suffixIcon: Icon(
                        Icons.sensor_window_outlined,
                        color: Colors.blueGrey,
                      ),
                      labelText: "Size In Marlas",
                      hintText: "(Required)",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) {
                      if (val.length > 3 || val.length < 1) {
                        return 'Enter a valid size';
                      } else if (int.parse(val) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    }),
                    onChanged: (val) {
                      setState(() {
                        sizeInMarlas = double.parse(val);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // initialValue: widget._rentalLifeUser.phoneNum,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    // autofocus: true,
                    decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //     padding: EdgeInsets.all(15), child: Text('+92 ')),
                      suffixIcon: Icon(
                        Icons.sensor_window_outlined,
                        color: Colors.blueGrey,
                      ),
                      labelText: "Rent in Rupees",
                      hintText: "(Required)",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) {
                      if (val.length > 10 || val.length < 1) {
                        return 'Enter a valid rent amount';
                      } else if (int.parse(val) == null) {
                        return 'Enter a valid amount for rent';
                      }
                      return null;
                    }),
                    onChanged: (val) {
                      setState(() {
                        adRent = int.parse(val);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
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

  void updateUserInfo(RentalLifeUser rentalLifeUser) async {
    rentalLifeUser.incrementTotalAdscount();
    rentalLifeUser.addAdDocumentIdToList(getDocumentName());
    await Firestore.instance
        .collection('user')
        .document(rentalLifeUser.uid)
        .updateData({'adsDocumentsId': rentalLifeUser.adsDocumentIdList});
    FirestoreDatabaseServicesForUser(rentalLifeUserID: rentalLifeUser.uid)
        .createRentalLifeUserFirestoreDocument(rentalLifeUser);
  }

  String getDocumentName() {
    String adDocumentName = widget._rentalLifeUser.uid;
    String numberOfAds = widget._rentalLifeUser.totalAdsPosted.toString();
    adDocumentName = adDocumentName + numberOfAds;
    return adDocumentName;
  }

  Future storeAdDetailsDataToDocument(RentalLifeUser rentalLifeUser) async {
    String title =
        "Home for rent, with $numberOfRooms Rooms, $numberOfBaths Baths, "
        "of $sizeInMarlas Marlas, for $adRent Rupees per month.";
    DateTime dateTime = DateTime.now();

    return await Firestore.instance
        .collection('AdsDocument')
        .document(getDocumentName())
        .setData({
      'adTitle': title,
      'adOwnerId': rentalLifeUser.uid,
      'adOwnerName': rentalLifeUser.name,
      'phoneNumber': rentalLifeUser.phoneNum,
      'dateTime': dateTime,
      'adRent': adRent,
      'isAdDeactivated': isAdDeactivated,
      'totalRating': totalRating,
      'sizeInMarlas': sizeInMarlas,
      'floorNumber': floorNumber, //d
      'totalNumberOfFloors': totalNumberOfFloors, //d
      'numberOfRooms': numberOfRooms, //d
      'numberOfBaths': numberOfBaths, //d
    });

    //String adTitle;
    //   String adDescription;
    //   String adOwnerId;
    //   int adNumberByOwner;
    //   int numberOfAdImagesUploaded;
    //   String adLocation;
    //   String adPostDate;
    //   int adRent;
    //   bool isAdDeactivated;
    //   int totalThumbsUp;
    //   int totalRating;
    //   String adType;
    //   double latitude;
    //   double longitude;
    //   String locationDescription;
    //   DateTime now = new DateTime.now();

    print("User ID: ${rentalLifeUser.uid}");
    print("User Bio: ${rentalLifeUser.bio}");
    print("Ad Rent: ${adRent}");
    print("Size In Marlas: ${sizeInMarlas}");
    print("Total Number Of Floors: ${totalNumberOfFloors}");
    print("Floor For Rent: ${floorNumber}");
    print("Number Of Rooms: ${numberOfRooms}");
  }
}
