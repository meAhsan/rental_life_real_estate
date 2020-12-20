import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/MenuPages/AppMenuDrawerOvalRight.dart';
import 'package:realestate/Service%20Classes/FirebaseUserAuthenticationService.dart';
import 'package:realestate/Service%20Classes/FirestoreDatabaseServicesForUser.dart';

class RentalLifeHomePage extends StatefulWidget {

  // bool _toShowSnackbar = false;

  @override
  _RentalLifeHomePageState createState() => _RentalLifeHomePageState();
}

// final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _RentalLifeHomePageState extends State<RentalLifeHomePage> {
  FirebaseUserAuthenticationService _authService =
      FirebaseUserAuthenticationService();

  @override
  Widget build(BuildContext context) {

    final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);
    return FutureProvider<RentalLifeUser>.value(
        value: FirestoreDatabaseServicesForUser(
                rentalLifeUserID: rentalLifeUserFromProvider.uid)
            .getRentalLifeUserFromFireStoreDocument(),
        child: Scaffold(
          // key: _scaffoldKey,

          appBar: AppBar(title: Text("RentalLifeHome"), actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _authService.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Sign Out')),
          ]),
          body: Column(
            children: [
              Text("RentalLifeHome Body"),
              Text(
                  "Rental Life User Name:  ${rentalLifeUserFromProvider.name}"),
              Text("Rental Life User uid: ${rentalLifeUserFromProvider.uid}"),
              Text(
                  "Rental Life User email: ${rentalLifeUserFromProvider.emailAddress}"),
            ],
          ),
          drawer: AppMenuDrawerOvalRight(),

          // drawer: AppMenuDrawer(),
        ));
  }
}
