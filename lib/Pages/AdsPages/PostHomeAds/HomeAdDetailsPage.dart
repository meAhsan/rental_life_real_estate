import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeAdDetailsPage extends StatefulWidget {
  final GlobalKey<FormState> _formKey;

  HomeAdDetailsPage(this._formKey);

  @override
  _HomeAdDetailsPageState createState() => _HomeAdDetailsPageState();
}

class _HomeAdDetailsPageState extends State<HomeAdDetailsPage>
    with AutomaticKeepAliveClientMixin<HomeAdDetailsPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Form(
                  // onChanged: _onFormChange,
                  // onWillPop: _onWillPop,
                  key: widget._formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16.0),
                    children: <Widget>[
                      TextFormField(
                        onSaved: ((val) {
                          print('saved val: $val');
                        }),
                        // initialValue: widget._rentalLifeUser.name,//_name,
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
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // TextFormField(
                      //   initialValue: widget._rentalLifeUser.phoneNum,
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   // autofocus: true,
                      //   decoration: InputDecoration(
                      //     prefixIcon: Padding(
                      //         padding: EdgeInsets.all(15), child: Text('+92 ')),
                      //     suffixIcon: Icon(
                      //       Icons.phone_android_sharp,
                      //       color: Colors.blueGrey,
                      //     ),
                      //     labelText: "Mobile # ",
                      //     hintText: "(Required)",
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   validator: ((val) {
                      //     if (val.length > 10) {
                      //       return 'Mobile Number too long';
                      //     } else if (val.length < 10) {
                      //       return 'Mobile Number too short';
                      //     }
                      //     return null;
                      //   }),
                      //   onChanged: (val) {
                      //     setState(() {
                      //       _phoneNum = val; //(val as int);
                      //     });
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //   initialValue: widget._rentalLifeUser.age.toString(),
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //     suffixIcon: Icon(
                      //       Icons.calendar_today_rounded,
                      //       color: Colors.blueGrey,
                      //     ),
                      //     labelText: "Age ",
                      //     hintText: "Required",
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   validator: ((val) {
                      //     if (val.length > 2) {
                      //       return 'Invalid age. Should be in year.';
                      //     }
                      //     return null;
                      //   }),
                      //   onChanged: (val) {
                      //     setState(() {
                      //       _age = val;
                      //     });
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //   initialValue: widget._rentalLifeUser.emailAddress,
                      //   enabled: false,
                      //   decoration: InputDecoration(
                      //     suffixIcon: Icon(
                      //       Icons.email,
                      //       color: Colors.blueGrey,
                      //     ),
                      //     labelText: "Email ",
                      //     border: OutlineInputBorder(),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //   initialValue: widget._rentalLifeUser.bio,
                      //   maxLines: 10,
                      //   decoration: InputDecoration(
                      //     suffixIcon: Icon(
                      //       Icons.info,
                      //       color: Colors.blueGrey,
                      //     ),
                      //     labelText: "Bio ",
                      //     hintText: "Required",
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   validator: ((val) => (val.length <= 10 ||
                      //       val.length >= 180)
                      //       ? 'Bio should be minimum 10 and maximum 180 characters long.'
                      //       : null),
                      //   onChanged: (val) {
                      //     setState(() {
                      //       _bio = val;
                      //     });
                      //   },
                      // ),
                      // Divider(
                      //   height: 32.0,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: FlatButton(
                      //         textColor: Colors.red[400],
                      //         child: Text("Cancel"),
                      //         onPressed: () async {
                      //           // bool toCancel = await _onWillPop();
                      //           // print(" Cancel Button");
                      //
                      //           // if (toCancel) {
                      //             // print("CANCELLED");
                      //             Navigator.pop(context, "Cancelled");
                      //             // _firebaseUserAuthenticationService.signOut();
                      //           }
                      //         },
                      //       ),
                      //     ),
                      //     Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: RaisedButton(
                      //           color: Colors.red,
                      //           textColor: Colors.white,
                      //           elevation: 0,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20.0),
                      //           ),
                      //           child: Text("Update"),
                      //           onPressed: (() {
                      //
                      //             // _submitUserPersonalInfoForm(
                      //             //     widget._rentalLifeUser);
                      //             final snackBar = SnackBar(
                      //               content: Text('Yay! A SnackBar!'),
                      //               action: SnackBarAction(
                      //                 label: 'Undo',
                      //                 onPressed: () {
                      //                   // Some code to undo the change.
                      //                 },
                      //               ),
                      //             );
                      //           }
                      //           ),
                      //         ))
                      //   ],
                      // ),
                    ],
                  ),
                ))));
  }
}
