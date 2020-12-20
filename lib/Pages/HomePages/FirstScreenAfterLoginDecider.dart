import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/MenuPages/AppMenuDrawer.dart';
import 'package:realestate/Pages/MenuPages/AppMenuDrawerOvalRight.dart';
import 'package:realestate/Pages/MenuPages/RentalLifeBottomNavigationBar.dart';
import 'package:realestate/Pages/SettingsPages/AddUserPersonalInfoSettings.dart';
import 'package:realestate/Service%20Classes/FirebaseUserAuthenticationService.dart';
import 'package:realestate/screens/home/user_List.dart';
import 'package:realestate/shared/loading.dart';

import 'RentalLifeHomePage.dart';

class FirstScreenAfterLoginDecider extends StatefulWidget {
  @override
  _FirstScreenAfterLoginDeciderState createState() =>
      _FirstScreenAfterLoginDeciderState();
}

class _FirstScreenAfterLoginDeciderState
    extends State<FirstScreenAfterLoginDecider> {
  FirebaseUserAuthenticationService _authService =
      FirebaseUserAuthenticationService();
  bool isUserDocumentExists = false;
  bool isLoading = true;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);

    final usersRef = Firestore.instance
        .collection('user')
        .document(rentalLifeUserFromProvider.uid);
    if (firstTime) {
      // firstTime = false;
      usersRef.get().then((docSnapshot) => {
            if (docSnapshot.exists) //&& isLoading)
              {
                setState(() {
                  // print("SAFDASD");
                  isLoading = false;
                  isUserDocumentExists = true;
                })
              }
            else //if(isLoading)
              {
                setState(() {
                  // print("ASFDASD");
                  isLoading = false;
                  isUserDocumentExists = false;
                })
              }
          });
    }

    if (isLoading) {
      return Loading();
    } else {
      if (isUserDocumentExists) {
        // return DarkDrawerPage();
        setState(() {
          firstTime = false;
        });
        return RentalLifeBottomNavigationBar();//RentalLifeHomePage();
      } else {
        return AddUserPersonalInfoSettings();
        // return Scaffold(
        //   appBar: AppBar(title: Text("User Settings page."), actions: <Widget>[
        //     FlatButton.icon(
        //         onPressed: () async {
        //           await _authService.signOut();
        //         },
        //         icon: Icon(Icons.person),
        //         label: Text('Sign Out')),
        //   ]),
        //   body: Column(
        //     children: [
        //       Text(
        //           "User document data doesn't exist because user didn't upload data. Update this field first.")
        //     ],
        //   ),
        // );
      }
    }
  }
}
