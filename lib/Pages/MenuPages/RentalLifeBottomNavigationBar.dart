import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/ModelClasses/UserModelClasses/RentalLifeUser.dart';
import 'package:realestate/Pages/AdsPages/AdsMainPage.dart';
import 'package:realestate/Pages/AdsPages/BottomRevealPostAdPage.dart';
import 'package:realestate/Pages/AdsPages/DisplayAdPages/HomeAdDetailedDisplayPage.dart';
import 'package:realestate/Pages/AdsPages/DisplayAdPages/HomeAdsCards.dart';
import 'package:realestate/Pages/ChatPages/ChatRoomsScreen.dart';
import 'package:realestate/Pages/ChatPages/SearchChat.dart';
import 'package:realestate/Pages/ImagesPages/first.dart';
import 'package:realestate/Pages/MenuPages/AppMenuDrawerOvalRight.dart';
import 'package:realestate/Pages/SearchUserAdsPages/SearchUserAdsFirstPage.dart';
import 'package:realestate/Pages/SettingsPages/RentalLifeUserProfile.dart';
import 'package:realestate/Service%20Classes/FirebaseUserAuthenticationService.dart';
import 'package:realestate/Service%20Classes/FirestoreDatabaseServicesForUser.dart';

class RentalLifeBottomNavigationBar extends StatefulWidget {
  @override
  _RentalLifeBottomNavigationBarState createState() =>
      _RentalLifeBottomNavigationBarState();
}

Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;

class _RentalLifeBottomNavigationBarState
    extends State<RentalLifeBottomNavigationBar> {
  int _currentPage;
  FirebaseUserAuthenticationService _authService =
      FirebaseUserAuthenticationService();

  // RentalLifeUser get rentalLifeUserFromProvider => null;

  @override
  void initState() {
    _currentPage = 0;
    super.initState();
  }

  var rentalLifeUserFromProvider;

  @override
  Widget build(BuildContext context) {
    rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);

    return FutureProvider<RentalLifeUser>.value(
        catchError: (context, error) {
          print("Error: $error");
          return null;
        },
        value: FirestoreDatabaseServicesForUser(
                rentalLifeUserID: rentalLifeUserFromProvider.uid)
            .getRentalLifeUserFromFireStoreDocument(),
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text("Animated Bottom Navigation Bar"),
          // ),
          backgroundColor: Colors.grey.shade300,
          body: getPage(_currentPage),
          bottomNavigationBar: AnimatedBottomNav(
              currentIndex: _currentPage,
              onChange: (index) {
                setState(() {
                  _currentPage = index;
                });
              }),
          // drawer: AppMenuDrawerOvalRight(),
        ));
  }

  getPage(int page) {
    switch (page) {
      case 0:
        return //First();
            Center(
                //child: Container(
          child: HomeAdsCardsPage(), //Text("Home Page"),
        //)
    );
      case 1:
        return SearchUserAdsFirstPage();


        case 2:
        return BottomRevealPostAdPage();
      //AdsMainPage();
      // return Center(
      //     child: Container(
      //   child: Text("Profile Page"),
      // ));
      case 3:
        // return BottomRevealAdMainPage();
        return ChatRoom(rentalLifeUserFromProvider);
    //SearchChatScreen(rentalLifeUserFromProvider);
        //   Center(
        //     child: Container(
        //   child: RaisedButton(
        //     child: Text("Press to reveal ad details."),
        //     onPressed: () async {
        //       // final tempAdDocumnet = Firestore.instance
        //       //     .collection('AdsDocument')
        //       //     .document("XBAM8FwVLZPNXd4DhXT9Ftn67Zh21");
        //       // final DocumentSnapshot docSnapshot = await tempAdDocumnet.get();
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => HomeAdsCardsPage()),
        //         //HomeAdDetailedDisplayPage(docSnapshot)
        //       );
        //     },
        //   ),
        // ));
    }
  }
}

class AnimatedBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;

  const AnimatedBottomNav({Key key, this.currentIndex, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rentalLifeUserFromProvider = Provider.of<RentalLifeUser>(context);
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: firstColor),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onChange(0),
              child: BottomNavItem(
                activeColor: secondColor,
                //inactiveColor: fourthColor,
                icon: Icons.home,
                title: "Home",
                isActive: currentIndex == 0,
              ),
            ),
          ),Expanded(
            child: InkWell(
              onTap: () => onChange(1),
              child: BottomNavItem(
                activeColor: secondColor,
                //inactiveColor: fourthColor,
                icon: Icons.search,
                title: "Search",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(2),
              child: BottomNavItem(
                activeColor: secondColor,
                icon: Icons.camera_alt_outlined,
                title: "Ads",
                isActive: currentIndex ==2,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(3),
              child: BottomNavItem(
                activeColor: secondColor,
                icon: Icons.chat,
                title: "Chats",
                isActive: currentIndex == 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final Color activeColor;
  final Color inactiveColor;
  final String title;

  const BottomNavItem(
      {Key key,
      this.isActive = false,
      this.icon,
      this.activeColor,
      this.inactiveColor,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 200),
      child: isActive
          ? Container(
              color: firstColor,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            )
          : Icon(
              icon,
              color: inactiveColor ?? Colors.grey,
            ),
    );
  }
}
