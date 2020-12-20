import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/HomePages/FirstScreenAfterLoginDecider.dart';
import 'package:realestate/Pages/HomePages/RentalLifeHomePage.dart';
import 'package:realestate/Pages/SettingsPages/RentalLifeUserProfile.dart';
import 'package:realestate/Pages/SettingsPages/UpdateUserPersonalInfo.dart';
import 'package:realestate/Service%20Classes/FirebaseUserAuthenticationService.dart';

class AppMenuDrawerOvalRight extends StatelessWidget {
  final Color primary = Color(0xff291747);
  final Color active = Color(0xff6C48AB);
  FirebaseUserAuthenticationService _firebaseUserAuthenticationService =
      FirebaseUserAuthenticationService();

  @override
  Widget build(BuildContext context) {
    // final String image =
    //     "";
    final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    child: FlatButton.icon(
                      label: Text(
                        "Logout",
                        style: TextStyle(color: active),
                      ),
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {
                        _firebaseUserAuthenticationService.signOut();
                      },
                    ),
                    // child: IconButton(
                    //
                    //   icon: Icon(
                    //     Icons.power_settings_new,
                    //     color: active,
                    //   ),
                    //   onPressed: () {
                    //     _firebaseUserAuthenticationService.signOut();
                    //   },
                    // ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.deepPurple])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(rentalLifeUserFromProvider.userDisplayImageAddress),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    rentalLifeUserFromProvider.name,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    rentalLifeUserFromProvider.emailAddress,
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, "Home"),
                  _buildDivider(),
                  GestureDetector(
                      onTap: (() async {
                        String result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RentalLifeUserProfile(
                                    rentalLifeUserFromProvider)));
                      }),
                      child: _buildRow(Icons.person_pin, "Your profile")),
                  _buildDivider(),
                  GestureDetector(
                    child: _buildRow(Icons.settings, "Settings"),
                    onTap: (() async {
                      String result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateUserPersonalInfoSettings(
                                      rentalLifeUserFromProvider)));
                      if (result.compareTo('Updated') == 0) {
                        Navigator.pop(context);
                        Navigator.pop(context, "UserdocumentChanged");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstScreenAfterLoginDecider()));

                        // final flushbar = Flushbar(
                        //     title: "Some",
                        //     message: "text",
                        //     duration: Duration(seconds: 3),
                        //     mainButton: FlatButton(onPressed: () {}));

                        // final snackBar = SnackBar(
                        //   content: Text('Yay! Profile Updated!'),
                        //   action: SnackBarAction(
                        //     label: 'Great',
                        //     onPressed: () {
                        //       // Navigator.pop(context);
                        //     },
                        //   ),
                        // );
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => flushbar));
                      }
                    }),
                    // () =>
                    // Navigator.push(context, MaterialPageRoute(
                    // builder: (context) => UpdateUserPersonalInfoSettings()),
                  ),
                  // ),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "Help"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: active,
    );
  }

  Widget _buildRow(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }
}
