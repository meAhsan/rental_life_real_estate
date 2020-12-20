import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/HomePages/FirstScreenAfterLoginDecider.dart';
import 'package:realestate/Pages/HomePages/RentalLifeHomePage.dart';
import 'package:realestate/Pages/SettingsPages/UpdateUserPersonalInfo.dart';

class RentalLifeUserProfile extends StatefulWidget {
  RentalLifeUser _rentalLifeUser;

  RentalLifeUserProfile(this._rentalLifeUser);

  @override
  _RentalLifeUserProfileState createState() => _RentalLifeUserProfileState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _RentalLifeUserProfileState extends State<RentalLifeUserProfile> {

  @override
  Widget build(BuildContext context) {
    // RentalLifeUser _rentalLifeUser = Provider.of<RentalLifeUser>(context);
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, .9),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 330,
                    color: Colors.deepOrange,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: FlatButton.icon(
                      label: Text(
                        "Settings",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        String result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateUserPersonalInfoSettings(
                                        widget._rentalLifeUser)));
                        if (result.compareTo('Updated') == 0) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context, "UserdocumentChanged");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirstScreenAfterLoginDecider()));
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => RentalLifeUserProfile(widget._rentalLifeUser)));
                          //final snackBar =
                          // _scaffoldKey.currentState.showSnackBar(
                          //     SnackBar(
                          //       content: Text('Yay! A SnackBar!'),
                          //       duration: Duration(seconds: 3),
                          //       action: SnackBarAction(
                          //         label: 'Undo',
                          //         onPressed: () {
                          //           // Some code to undo the change.
                          //         },
                          //       ),
                          //     ));
                        }
                      },
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      // Container(
                      //     height: 90,
                      //     margin: EdgeInsets.only(top: 60),
                      //     child: CircleAvatar(
                      //       radius: 50,
                      //       backgroundColor: Colors.white,
                      //       child: PNetworkImage(
                      //           "https://lh3.googleusercontent.com/ogw/ADGmqu_y5fygpa9lyMo25tkCPurKjT0K579xX5UCogHaBw=s83-c-mo"),
                      //     )),
                      Container(
                        height: 150,
                        margin: EdgeInsets.only(top: 60),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [Colors.white, Colors.deepOrangeAccent])),
                        child: CircleAvatar(
                          radius: 73,
                          backgroundImage: NetworkImage(widget._rentalLifeUser.userDisplayImageAddress
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        widget._rentalLifeUser.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        ("${widget._rentalLifeUser.age.toString()} years old."),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 5),
                                      child: Text("Ads Posted",
                                          style: TextStyle(
                                              color: Colors.black54))),
                                  Container(
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: Text(
                                          widget._rentalLifeUser.totalAdsPosted
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16))),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 5),
                                      child: Text("Tenants Connected",
                                          style: TextStyle(
                                              color: Colors.black54))),
                                  Container(
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: Text(widget._rentalLifeUser.totalTenantsConnected.toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16))),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 5),
                                      child: Text("Owners Connected",
                                          style: TextStyle(
                                              color: Colors.black54))),
                                  Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(widget._rentalLifeUser.totalOwnersConnected.toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Card(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "User Information",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black38,
                                    ),
                                    Container(
                                        child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.my_location),
                                          title: Text("Location"),
                                          subtitle: Text("Rawalpindi"),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text("Email"),
                                          subtitle: Text(widget
                                              ._rentalLifeUser.emailAddress),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone),
                                          title: Text("Phone"),
                                          subtitle: Text(
                                              widget._rentalLifeUser.phoneNum),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person),
                                          title: Text("About Me"),
                                          subtitle:
                                              Text(widget._rentalLifeUser.bio),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

// class UserInfo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }

class PNetworkImage extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double width, height;

  const PNetworkImage(this.image, {Key key, this.fit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      // errorWidget: (context, url, error) => Image.asset('assets/placeholder.jpg',fit: BoxFit.cover,),
      fit: fit,
      width: width,
      height: height,
    );
  }
}
