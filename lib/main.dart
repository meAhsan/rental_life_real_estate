import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/screens/wrapper.dart';
import 'package:realestate/services/auth.dart';
import 'Service Classes/FirebaseUserAuthenticationService.dart';
import 'WrapperClasses/AuthenticationWrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Old app
    // return StreamProvider<User>.value(
    //   value: AuthService().user,
    //   child: MaterialApp(
    //      home:
    //      Wrapper()
    //   ),

    //NewApp

    return StreamProvider<RentalLifeUser>.value(
      value: FirebaseUserAuthenticationService().rentalLifeUserFromAuthService,
      child: MaterialApp(
        home: AuthenticationWrapper(),
      ),

    );
  }
}
