import 'package:flutter/material.dart';
import 'package:bottomreveal/bottomreveal.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/AdsPages/PostNonCommercialAdPage.dart';

import 'AdsMainPage.dart';
import 'PostCommercialAdPage.dart';

class BottomRevealPostAdPage extends StatefulWidget {



  @override
  _BottomRevealPostAdPageState createState() => _BottomRevealPostAdPageState();
}

Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;

class _BottomRevealPostAdPageState extends State<BottomRevealPostAdPage> {
  final BottomRevealController _menuController = BottomRevealController();
  var rentalLifeUserFromProvider;
  @override
  Widget build(BuildContext context) {
    rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bottom Reveal Example App'),
      // ),
      body: BottomReveal(
        openIcon: Icons.add,
        closeIcon: Icons.minimize,
        revealWidth: 100,
        revealHeight: 100,
        backColor: Color(0xff2D0C3F),
        frontColor: Colors.grey.shade200,
        rightContent: _buildRightMenu(),
        bottomContent: _buildBottomContent(),
        controller: _menuController,
        body: //Center(child: Text(rentalLifeUserFromProvider.toString()))
        AdsMainPage(),
      ),
    );
  }

  Widget _buildBottomContent() {
    return Container(
      decoration: BoxDecoration(
        color: secondColor,
        border: Border.all(
          color: Colors.red,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(19),
        // filled: true,
        // fillColor: Colors.grey,
        // contentPadding: const EdgeInsets.all(16.0),
        // prefixIcon: Icon(Icons.search, color: Colors.white,),
        // border: OutlineInputBorder(
        //     gapPadding: 8.0,
        //     borderSide: BorderSide(color: Colors.grey),
        //     borderRadius: BorderRadius.circular(30.0)
        // )
      ),
      // color: secondColor,//
      padding: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PostNonCommercialAdPage(rentalLifeUserFromProvider)));
        }),
        child: Row(
          children: [
            Icon(Icons.home, color: firstColor),
            SizedBox(
              width: 10,
            ),
            Text(
              "Post Non-Commercial Ad",
              style: TextStyle(
                color: firstColor,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
    //   TextField(
    //
    //   style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 18.0
    //   ),
    //   decoration: InputDecoration(
    //     filled: true,
    //     fillColor: Colors.grey,
    //     contentPadding: const EdgeInsets.all(16.0),
    //     prefixIcon: Icon(Icons.search, color: Colors.white,),
    //     border: OutlineInputBorder(
    //         gapPadding: 8.0,
    //         borderSide: BorderSide(color: Colors.grey),
    //         borderRadius: BorderRadius.circular(30.0)
    //     ),
    //   ),
    // );
  }

  Widget _buildRightMenu() {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: secondColor,
          border: Border.all(
            color: Colors.red,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(19),
          // filled: true,
          // fillColor: Colors.grey,
          // contentPadding: const EdgeInsets.all(16.0),
          // prefixIcon: Icon(Icons.search, color: Colors.white,),
          // border: OutlineInputBorder(
          //     gapPadding: 8.0,
          //     borderSide: BorderSide(color: Colors.grey),
          //     borderRadius: BorderRadius.circular(30.0)
          // )
        ),
        // color: secondColor,//
        padding: EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostCommercialAdPage()));
          }),
          child: Row(
            children: [
              Icon(Icons.monetization_on, color: firstColor),
              SizedBox(
                width: 10,
              ),
              Text(
                "Post Commercial Ad",
                style: TextStyle(
                  color: firstColor,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: <Widget>[
    //     MaterialButton(
    //       height: 60.0,
    //       padding: const EdgeInsets.all(0),
    //       textColor: Colors.white,
    //       minWidth: 60,
    //       child: Icon(
    //         Icons.video_library,
    //         size: 50,
    //       ),
    //       color: Color(0xff644B77),
    //       elevation: 0,
    //       onPressed: () {
    //         _menuController.close();
    //       },
    //     ),
    //     const SizedBox(height: 10.0),
    //     MaterialButton(
    //       height: 60.0,
    //       padding: const EdgeInsets.all(0),
    //       textColor: Colors.white,
    //       minWidth: 60,
    //       child: Icon(
    //         Icons.photo,
    //         size: 50,
    //       ),
    //       color: Color(0xff644B77),
    //       elevation: 0,
    //       onPressed: () {
    //         _menuController.close();
    //       },
    //     ),
    //     const SizedBox(height: 10.0),
    //     MaterialButton(
    //       height: 60.0,
    //       padding: const EdgeInsets.all(0),
    //       textColor: Colors.white,
    //       minWidth: 60,
    //       child: Icon(
    //         Icons.camera_alt,
    //         size: 30,
    //       ),
    //       color: Color(0xff644B77),
    //       elevation: 0,
    //       onPressed: () {
    //         _menuController.close();
    //       },
    //     ),
    //   ],
    // );
  }
}
