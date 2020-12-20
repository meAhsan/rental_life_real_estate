import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/AdsPages/PostHomeAds/HomeAdDescriptionPage.dart';
import 'package:realestate/Pages/AdsPages/PostHomeAds/HomeAdImagesPage.dart';

import 'HomeAdDetailsPage.dart';

class PostHomeAdPage extends StatefulWidget {
  RentalLifeUser _rentalLifeUser;

  PostHomeAdPage(this._rentalLifeUser);

  @override
  _PostHomeAdPageState createState() => _PostHomeAdPageState();
}

Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;

bool isDetailsTabCompleted = false;
bool isDescriptionTabCompleted = false;
bool isImagesTabCompleted = false;

class _PostHomeAdPageState extends State<PostHomeAdPage> {
  String details;

  @override
  Widget build(BuildContext context) {
    final FormDetailsKey = GlobalKey<FormState>(); //const Key('__PHAKEY1__');
    final FormDescriptionKey = GlobalKey<FormState>();
    final FormImagesKey = GlobalKey<FormState>(); //const Key('__PHAKEY3__');
    // final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);
    // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              RaisedButton.icon(
                icon: Icon(Icons.point_of_sale),
                label: Text("validate"),
                onPressed: (() {
                  print(FormDescriptionKey);
                  if (FormDescriptionKey.currentState.validate() &&
                      FormDetailsKey.currentState.validate() && FormImagesKey.currentState.validate()) {
                    print("Form validated");
                    FormDetailsKey.currentState.save();
                    print("Details $details");
                  } else {
                    print("Form not validated");
                  }
                }),
              )
            ],
            backgroundColor: firstColor,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(FontAwesomeIcons.questionCircle)),
                Tab(
                  icon: Icon(Icons.description),
                ),
                Tab(icon: Icon(Icons.camera_alt_outlined /*Icons.camera*/)),
              ],
            ),
            title: Text('Post Home Ad'),
          ),
          body: TabBarView(children: [
            HomeAdDetailsPage(FormDetailsKey),
            HomeAdDescriptionPage(FormDescriptionKey),
            HomeAdImagesPage(),
          ]
            //             if(isDetailsTabCompleted == false){
            //         children: [
            //         HomeAdDetailsPage(),
            //         HomeAdDescriptionPage(),
            //         HomeAdImagesPage(),
            //         ]
            //
            //         }else
            //             if(isDescriptionTabCompleted == false){
            //     children: [
            //     HomeAdDetailsPage(),
            //     HomeAdDescriptionPage(),
            //     HomeAdImagesPage(),
            //     ]
            //     }else
            //         if(isImagesTabCompleted== false){
            // children: [
            // HomeAdDetailsPage(),
            // HomeAdDescriptionPage(),
            // HomeAdImagesPage(),
            // ]
            // }else{
            //
            // }

            // Text(widget._rentalLifeUser.toString()),

          ),
        ),
      ),
    );
  }
}
