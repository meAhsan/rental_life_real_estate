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

class AddUserPersonalInfoSettings extends StatefulWidget {
  @override
  _AddUserPersonalInfoSettingsState createState() =>
      _AddUserPersonalInfoSettingsState();
}

class _AddUserPersonalInfoSettingsState extends State<AddUserPersonalInfoSettings> {

  FirebaseUserAuthenticationService _firebaseUserAuthenticationService = FirebaseUserAuthenticationService();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool _formChanged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  String _name;
  String _phoneNum;
  String _age;

  // String _emailAddress;
  String _userDisplayImageAddress;
  int _totalAdsPosted;
  String _bio;

  @override
  Widget build(BuildContext context) {
    final rentalLifeUser = Provider.of<RentalLifeUser>(context);
    // return Scaffold(
    //     appBar: new AppBar(
    //   backgroundColor: Colors.red[600],
    //   centerTitle: true,
    //   title: Form(
    //     key: _formKey,
    //     onChanged: _onFormChange,
    //     onWillPop: _onWillPop,
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: <Widget>[
    //           // _titleField,
    //           // _costField,
    //           // _dateAddedField,
    //           // // _categoryDropdownField,
    //           // _imageField,
    //           Divider(
    //             height: 32.0,
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: <Widget>[
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: FlatButton(
    //                   textColor: Colors.red[400],
    //                   child: Text("Cancel"),
    //                   onPressed: () {
    //                     Navigator.pop(context);
    //                   },
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: RaisedButton(
    //                   color: Colors.blue[400],
    //                   child: Text("Submit"),
    //                   onPressed: _submitForm,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ));

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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofocus: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.drive_file_rename_outline,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Name",
                          hintText: "Required",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          print(
                              "Name field VAlue length: ${val.length}, val: $val");
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // autofocus: true,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(15), child: Text('+92 ')),
                          suffixIcon: Icon(
                            Icons.phone_android_sharp,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Mobile Number ",
                          hintText: "(Required)",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          print(
                              "Phone # VAlue length: ${val.length}, val: $val");
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
                      // TextFormField(
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //     prefixIcon: Padding(
                      //         padding: EdgeInsets.all(15), child: Text('+92 ')),
                      //     suffixIcon: Icon(
                      //       Icons.phone_android_sharp,
                      //       color: Colors.blueGrey,
                      //     ),
                      //     labelText: "Mobile Number ",
                      //     hintText: "(Optional)",
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   validator: ((val) {
                      //     print("Phone # VAlue length: ${val.length}, val: $val");
                      //     if (val.length > 10) {
                      //       return 'Mobile Number too long';
                      //     }  else if (val.length < 10) {
                      //       return 'Mobile Number too short';
                      //     }
                      //     return null;
                      //   }),
                      //   onChanged: (val) {
                      //     setState(() {
                      //       _phoneNum = (val as int);
                      //
                      //     });
                      //   },
                      // ),
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Age",
                          hintText: "Required",
                          border: OutlineInputBorder(),
                        ),
                        validator: ((val) {
                          if (val.length > 2 || val.length==0) {
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
                        enabled: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.blueGrey,
                          ),
                          labelText: rentalLifeUser.emailAddress,
                          border: OutlineInputBorder(),
                        ),
                        // onChanged: (val) {
                        //   setState(() {
                        //     _age = val as int;
                        //   });
                        // },
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.info,
                            color: Colors.blueGrey,
                          ),
                          labelText: "Update your bio",
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
                                if (toCancel) {
                                  //Navigator.pop(context);
                                  _firebaseUserAuthenticationService.signOut();
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
                              child: Text("Submit"),
                              onPressed: (() =>
                                  _submitUserPersonalInfoForm(rentalLifeUser)),
                            ),
                          )
                        ],
                      ),
                      // RaisedButton(
                      //     color: Colors.red,
                      //     textColor: Colors.white,
                      //     elevation: 0,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20.0),
                      //     ),
                      //     child: Text("Next"),
                      //     onPressed: () async {
                      //       if (_formKey.currentState.validate()) {
                      //         /*Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => BottomNavigationWidget()),
                      //     );*/
                      //         //create new document for the this ad
                      //         // await AdsFirestoreService(uid: user.uid)
                      //         //     .updateAdData(title, desc, user.uid);
                      //
                      //         // Navigator.push(
                      //         //   context,
                      //         //   MaterialPageRoute(
                      //         //       builder: (context) => ImageCapture()),
                      //         // );
                      //       }
                      //     }),
                    ],
                  ),
                ))));
  }

  /// ****************
  /// Form Widgets Region
  ///
  Widget get _titleField {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FormFieldContainer(
        child: Scaffold(
          body: Container(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                helperText: "Required",
                labelText: "Title",
              ),
              autofocus: true,
              validator: (String val) {
                if (val.isEmpty) {
                  return "Field cannot be left blank";
                }
                return null;
              },
              // onSaved: (String val) => _newProduct.title = val,
            ),
          ),
        ),
      ),
    );
  }

  Widget get _costField {
    return FormFieldContainer(
      child: Scaffold(
        body: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Cost Per Unit",
            helperText: "Required",
          ),
          keyboardType: TextInputType.numberWithOptions(),
          autovalidate: true,
          validator: (String val) {
            if (val.isEmpty) {
              return "Field cannot be left blank";
            }
            if (double.tryParse(val) == null) {
              return "Field must contain a valid number.";
            }
            return null;
          },
          // onSaved: (String val) => _newProduct.cost = double.tryParse(val),
        ),
      ),
    );
  }

  // Widget get _categoryDropdownField {
  //   return FormFieldContainer(
  //     child: DropdownButtonFormField(
  //       decoration: InputDecoration(
  //         border: OutlineInputBorder(),
  //         labelText: "Category",
  //       ),
  //       // value: _newProduct.category,
  //       // onChanged: (ProductCategory newSelection) {
  //       //   setState(() => _newProduct.category = newSelection);
  //       // },
  //       // items: ProductCategory.values.map((ProductCategory category) {
  //       //   return DropdownMenuItem(value: category, child: Text(category.toString()));
  //       // }).toList(),
  //     ),
  //   );
  // }

  Widget get _dateAddedField {
    return FormFieldContainer(
      child: FormField(
        builder: (FormFieldState state) {
          return DateInputField(
            labelText: "Date Added",
            // valueText: _newProduct.dateAdded != null ? formatDate(_newProduct.dateAdded) : null,
            onPressed: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)));
              // setState(() => _newProduct.dateAdded = date);
            },
          );
        },
        onSaved: (val) {},
        validator: (val) {
          return null;
        },
        initialValue: formatDate(DateTime.now()),
      ),
    );
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

  // BoxDecoration get _image {
  //   // return _selected == null
  //       ? BoxDecoration(color: Colors.grey[300])
  //       : BoxDecoration(
  //     image: DecorationImage(image: FileImage(_selected), fit: BoxFit.cover),
  //   );
  // }

  ///
  /// End Form Widgets Region
  /// ****************
  /// ****************
  /// Form Callbacks Region
  ///
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

  void _submitUserPersonalInfoForm(RentalLifeUser userFromProvider) {
    final FormState form = _formKey.currentState;
    print("IN Submit method");
    if (_formKey.currentState.validate()) {
      RentalLifeUser rentalLifeUser = new RentalLifeUser(
          userID: userFromProvider.uid,
          name: _name,
          age:  int.parse(_age),
          emailAddress: userFromProvider.emailAddress,
          bio: _bio,
          phoneNum: _phoneNum,
          totalAdsPosted: userFromProvider.totalAdsPosted,
          userDisplayImageAddress: userFromProvider.userDisplayImageAddress,
      totalTenantsConnected: userFromProvider.totalTenantsConnected,
      totalOwnersConnected: userFromProvider.totalOwnersConnected);
      FirestoreDatabaseServicesForUser databaseServicesForUser =
          FirestoreDatabaseServicesForUser(
              rentalLifeUserID: userFromProvider.uid);
      databaseServicesForUser
          .createRentalLifeUserFirestoreDocument(
              rentalLifeUser);
    }
  }

// _formKey.currentState.save();
// // _bloc.addNewProduct.add(AddProductEvent(_newProduct));
// // _userBloc.addNewProductToUserProductsSink.add(NewUserProductEvent(_newProduct));
// Navigator.of(context).pop();
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

///
/// End Form Methods Region
/// ****************
String formatDate(DateTime d) {
  var month = d.month;
  var day = d.day;
  var year = d.year;
  return "$month/$day/$year";
}
