import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ApplyFiltersOnHomeAds.dart';

Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;

class SearchUserAdsFirstPage extends StatefulWidget {
  @override
  _SearchUserAdsFirstPageState createState() => _SearchUserAdsFirstPageState();
}

class _SearchUserAdsFirstPageState extends State<SearchUserAdsFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: firstColor,
          title: Text("Search an Ad"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Divider(height: 10, color: Colors.black,),

              Text("Select Commercial Property Type",
                  style: TextStyle(fontSize: 24, color: firstColor)),
              SizedBox(height: 10,),

              Divider(height: 10, color: Colors.black,),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton.icon(
                      color: firstColor,
                        icon: Icon(Icons.home_work, color: secondColor,),
                        label: Text("Shops", style: TextStyle(color: secondColor),),
                        onPressed: () {

                        },),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton.icon(
                      color: firstColor,
                      icon: Icon(FontAwesomeIcons.child, color: secondColor,),
                      label: Text("Marriage Halls", style: TextStyle(color: secondColor),),
                      onPressed: () {

                      },),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton.icon(
                      color: firstColor,
                      icon: Icon(Icons.work, color: secondColor,),
                      label: Text("Offices", style: TextStyle(color: secondColor),),
                      onPressed: () {

                      },),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton.icon(
                      color: firstColor,
                      icon: Icon(Icons.monetization_on_outlined, color: secondColor,),
                      label: Text("Others", style: TextStyle(color: secondColor),),
                      onPressed: () {

                      },),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              // SizedBox(height: 10,),
              Divider(height: 10, color: Colors.black,),

              Text("Select Nonommercial Property Type",
                  style: TextStyle(fontSize: 24, color: firstColor)),
              SizedBox(height: 10,),

              Divider(height: 10, color: Colors.black,),

              Row(
                children: [
                  Expanded(
                    child: RaisedButton.icon(
                      color: firstColor,
                      icon: Icon(Icons.home, color: secondColor,),
                      label: Text("Home", style: TextStyle(color: secondColor),),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ApplyFiltersOnHomeAds()));
                      },),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton.icon(
                      color: firstColor,
                      icon: Icon(Icons.apartment, color: secondColor,),
                      label: Text("Flats/Apartments", style: TextStyle(color: secondColor),),
                      onPressed: () {

                      },),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton.icon(
                      color: firstColor,
                      icon: Icon(Icons.home_work_outlined, color: secondColor,),
                      label: Text("Hostel", style: TextStyle(color: secondColor),),
                      onPressed: () {

                      },),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton.icon(
                      color: firstColor,
                      icon: Icon(Icons.home, color: secondColor,),
                      label: Text("Others", style: TextStyle(color: secondColor),),
                      onPressed: () {

                      },),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Divider(height: 10, color: Colors.black,),

            ],
          ),
        )
    );
  }
}
