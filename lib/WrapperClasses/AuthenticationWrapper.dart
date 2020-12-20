import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/AuthenticationPages/AuthenticationMainPage.dart';
import 'package:realestate/Pages/HomePages/FirstScreenAfterLoginDecider.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget _widget;

  Widget build(BuildContext context) {
    final rentalLifeUser = Provider.of<RentalLifeUser>(context);

    if (rentalLifeUser == null) {
      _widget = AuthenticationMainPage();
    } else {
      _widget = FirstScreenAfterLoginDecider(); //Home();
    }
    return _widget;
  }
}