import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/MenuPages/AppMenuDrawerOvalRight.dart';

class AdsMainPage extends StatefulWidget {
  @override
  _AdsMainPageState createState() => _AdsMainPageState();
}

Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;
class _AdsMainPageState extends State<AdsMainPage> {
  @override
  Widget build(BuildContext context) {
     final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        title: Text("My Ads"),
      ),
      body: Center(child: Text("")),//rentalLifeUserFromProvider.toString()
      drawer: AppMenuDrawerOvalRight(),
    );
  }
}
