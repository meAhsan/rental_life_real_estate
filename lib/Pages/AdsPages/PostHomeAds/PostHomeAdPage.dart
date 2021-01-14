import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/AdsPages/PostHomeAds/HomeAdDescriptionPage.dart';
import 'package:realestate/Pages/AdsPages/PostHomeAds/HomeAdImagesPage.dart';
import 'package:realestate/shared/loading.dart';

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
// bool isLoading = false;
class _PostHomeAdPageState extends State<PostHomeAdPage> {
  String details;

  @override
  Widget build(BuildContext context) {
    final FormDetailsKey = GlobalKey<FormState>(); //const Key('__PHAKEY1__');
    final FormDescriptionKey = GlobalKey<FormState>();
    final FormImagesKey = GlobalKey<FormState>(); //const Key('__PHAKEY3__');
    final _globalKey = GlobalKey<ScaffoldState>();
    // final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);
    // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _globalKey,
          appBar: AppBar(
            actions: [
              ButtonTheme(
                minWidth: 200.0,
                height: 100.0,
                child: RaisedButton.icon(
                  color: firstColor,
                  icon: Icon(
                    Icons.camera,
                    color: secondColor,
                  ),
                  label: Text(
                    "Validate and Post",
                    style: TextStyle(color: secondColor, fontSize: 16),
                  ),
                  onPressed: (() async{
                    //print(FormDescriptionKey);
                    if (FormDetailsKey.currentState.validate() &&
                        FormDescriptionKey.currentState.validate() &&
                        FormImagesKey.currentState.validate()) {
                      print("Form validated");
                      // setState(() {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => Loading()));
                      // });

                      await FormDetailsKey.currentState.save();
                      await FormDescriptionKey.currentState.save();
                      await FormImagesKey.currentState.save();
                      // Navigator.pop(
                      //     context);
                      print("Details $details");
                    } else {
                      // SnackBar _snackbar =
                      //     SnackBar(content: Text('Form Fields not validated'));
                      // if (!FormDetailsKey.currentState.validate()) {
                      //   _snackbar =
                      //       SnackBar(content: Text('Please Insert Ad Details'));
                      // } else if (!FormDescriptionKey.currentState.validate()) {
                      //   _snackbar = SnackBar(
                      //       content:
                      //           Text('Please Insert Description and Location'));
                      // } else if (!FormImagesKey.currentState.validate()) {
                      //   _snackbar = SnackBar(
                      //       content: Text('Please Insert Atleast one image'));
                      // }
                      // _globalKey.currentState.showSnackBar(_snackbar);
                      // setState(() {});
                      print("Form not validated");
                    }
                  }),
                ),
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
              indicatorColor: Colors.red,
              indicatorWeight: 5.0,
            ),
            title: Text('Post Home Ad'),
          ),
          body: TabBarView(children: [
            HomeAdDetailsPage(FormDetailsKey, widget._rentalLifeUser),
            HomeAdDescriptionPage(FormDescriptionKey, widget._rentalLifeUser),
            HomeAdImagesPage(FormImagesKey, widget._rentalLifeUser, _globalKey),
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
