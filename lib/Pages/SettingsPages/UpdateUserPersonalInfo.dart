import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/SettingsPages/DateInputField.dart';
import 'package:realestate/Pages/SettingsPages/FormFieldContainer.dart';
import 'package:realestate/Pages/SettingsPages/Style.dart';
import 'package:realestate/Service%20Classes/FirebaseUserAuthenticationService.dart';
import 'package:realestate/Service%20Classes/FirestoreDatabaseServicesForUser.dart';
import 'package:realestate/shared/loading.dart';

class UpdateUserPersonalInfoSettings extends StatefulWidget {
  RentalLifeUser _rentalLifeUser = null;


  UpdateUserPersonalInfoSettings(this._rentalLifeUser);

  @override
  _UpdateUserPersonalInfoSettingsState createState() =>
      _UpdateUserPersonalInfoSettingsState();
}

class _UpdateUserPersonalInfoSettingsState
    extends State<UpdateUserPersonalInfoSettings> {
  FirebaseUserAuthenticationService _firebaseUserAuthenticationService =
      FirebaseUserAuthenticationService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool _formChanged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool loading = false;
  String _name ;
  String _phoneNum;
  String _age;

  // String _userDisplayImageAddress;
  // int _totalAdsPosted;
  String _bio;
  // dynamic rentalLifeUserFromProvider;

  // bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    // final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);
    // print("Printing name");
    // print(_name);
    // print("Printing phone num");
    //
    // print(_phoneNum);
    // print("Printing age");
    //
    // print(_age);
    // print("Printing bio");
    //
    // print(_bio);

    // if (isFirstTime) {
    //   rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);
    //   final userFirestoreDocumentReference = Firestore.instance
    //       .collection('user')
    //       .document(rentalLifeUserFromProvider.uid);
    //   // print(rentalLifeUserFromProvider.uid);
    //   // DocumentSnapshot snapshot = userFirestoreDocumentReference.snapshots();
    //   userFirestoreDocumentReference.get().then((docSnapshot) {
    //     // final DocumentSnapshot docSnapshot = await userFirestoreDocumentReference.get();
    //
    //     setState(() {
    //       print("IN SET STATE METHDO");
    //       _name = docSnapshot.data['name'];
    //       _phoneNum = docSnapshot.data['phoneNum'];
    //       _age = docSnapshot.data['age'];
    //       _bio = docSnapshot.data['bio'];
    //       _name = docSnapshot.data['name'];
    //       isFirstTime = false;
    //
    //       print("Printing name");
    //       print(_name);
    //       print("Printing phone num");
    //
    //       print(_phoneNum);
    //       print("Printing age");
    //
    //       print(_age);
    //       print("Printing bio");
    //     });
    //   });
    //   // print("is First Time");
    //   //
    //   //   // _totalAdsPosted = docSnapshot.data['totalAdsPosted'];
    //   //   // _userDisplayImageAddress = docSnapshot.data['userDisplayImageAddress'];
    //   //   setState(() {
    //   //     print("Printing name");
    //   //     print(_name);
    //   //     print("Printing phone num");
    //   //
    //   //     print(_phoneNum);
    //   //     print("Printing age");
    //   //
    //   //     print(_age);
    //   //     print("Printing bio");
    //   //
    //   //     isFirstTime = false;
    //   //   });
    // }

    // final rentalLifeUser = Provider.of<RentalLifeUser>(context);

    // final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);

    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red[600],
          centerTitle: true,
          title: Column(children: [
            Text(
              "User Settings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            Text(
              "Update your Info",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 17,
              ),
            ),
          ]),
        ),
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Form(
                  onChanged: _onFormChange,
                  onWillPop: _onWillPop,
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16.0),
                    children: <Widget>[
                      TextFormField(
                        initialValue: widget._rentalLifeUser.name,//_name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // autofocus: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.drive_file_rename_outline,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Name ",
                          hintText: "Required",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length < 3) {
                            return 'Name too short';
                          } else if (val.length > 15) {
                            return 'Name too long';
                          }
                          return null;
                        }),
                        onChanged: (val) {
                          setState(() {
                            _name = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: widget._rentalLifeUser.phoneNum,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // autofocus: true,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(15), child: Text('+92 ')),
                          suffixIcon: Icon(
                            Icons.phone_android_sharp,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Mobile # ",
                          hintText: "(Required)",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length > 10) {
                            return 'Mobile Number too long';
                          } else if (val.length < 10) {
                            return 'Mobile Number too short';
                          }
                          return null;
                        }),
                        onChanged: (val) {
                          setState(() {
                            _phoneNum = val; //(val as int);
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: widget._rentalLifeUser.age.toString(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Age ",
                          hintText: "Required",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length > 2) {
                            return 'Invalid age. Should be in year.';
                          }
                          return null;
                        }),
                        onChanged: (val) {
                          setState(() {
                            _age = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: widget._rentalLifeUser.emailAddress,
                        enabled: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Email ",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: widget._rentalLifeUser.bio,
                        maxLines: 10,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.info,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Bio ",
                          hintText: "Required",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) => (val.length <= 10 ||
                                val.length >= 180)
                            ? 'Bio should be minimum 10 and maximum 180 characters long.'
                            : null),
                        onChanged: (val) {
                          setState(() {
                            _bio = val;
                          });
                        },
                      ),
                      Divider(
                        height: 32.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              textColor: Colors.red[400],
                              child: Text("Cancel"),
                              onPressed: () async {
                                bool toCancel = await _onWillPop();
                                // print(" Cancel Button");

                                if (toCancel) {
                                  // print("CANCELLED");
                                  Navigator.pop(context, "Cancelled");
                                  // _firebaseUserAuthenticationService.signOut();
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text("Update"),
                              onPressed: (() {

                                _submitUserPersonalInfoForm(
                                    widget._rentalLifeUser);
                                final snackBar = SnackBar(
                                  content: Text('Yay! A SnackBar!'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                              }
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ))));
  }

  Widget get _imageField {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 150.0,
          ),
          child: Container(
              // decoration: _image,
              ),
        ),
        // _selected == null ? Text("Select an image") : Container(),
        Positioned(
          right: 8.0,
          bottom: 8.0,
          child: FloatingActionButton(
            backgroundColor: AppColors.primary[500],
            foregroundColor: Colors.grey[300],
            child: Icon(Icons.photo_library),
            onPressed: () async {
              // File image = await ImagePicker.pickImage(source: ImageSource.gallery);
              // setState(() {
              //   _selected = image;
              // });
            },
          ),
        ),
      ],
    );
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

  void _submitUserPersonalInfoForm(RentalLifeUser userWithOldValues) {
    final FormState form = _formKey.currentState;
    print("IN Submit method");
    if (_formKey.currentState.validate()) {

// if(_name != null){
//   userWithOldValues.name = _name;
// }if(_age != null){
//   userWithOldValues = _name;
// }if(_name != null){
//   userWithOldValues.name = _name;
// }if(_name != null){
//   userWithOldValues.name = _name;
// }
//       RentalLifeUser rentalLifeUser
      widget._rentalLifeUser= new RentalLifeUser(
          userID: userWithOldValues.uid,
          name: _name?? userWithOldValues.name,
           age: int.parse((_age?? userWithOldValues.age.toString())),
          emailAddress: userWithOldValues.emailAddress,
          bio: _bio?? userWithOldValues.bio,
          phoneNum: _phoneNum?? userWithOldValues.phoneNum,
          totalAdsPosted: userWithOldValues.totalAdsPosted,
          userDisplayImageAddress: userWithOldValues.userDisplayImageAddress);
      FirestoreDatabaseServicesForUser databaseServicesForUser =
          FirestoreDatabaseServicesForUser(
              rentalLifeUserID: userWithOldValues.uid);
      databaseServicesForUser
          .createRentalLifeUserFirestoreDocument(
          widget._rentalLifeUser);
      FirestoreDatabaseServicesForUser(rentalLifeUserID:userWithOldValues.uid ).getRentalLifeUserFromFireStoreDocument();
      Navigator.pop(context, 'Updated');
      //Navigator.pop(context);
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
