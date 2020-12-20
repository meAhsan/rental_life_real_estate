// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:realestate/Bloc%20Classes/UserBloc.dart';
// import 'file:///C:/Users/msnk5/StudioProjects/rental_life_real_estate/lib/ModelClasses/UserModelClasses/RentalLifeUser.dart';
//
// class UserBlocTestPage{
//
// }
//
// class UserBlocTest extends StatefulWidget {
//   @override
//   _UserBlocTestState createState() => _UserBlocTestState();
// }
//
// class _UserBlocTestState extends State<UserBlocTest> {
//   final UserBloc _userbloc = new UserBloc();
// @override
//   void disposeAllStreams(){
//     _userbloc.disposeAllStreams();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User App"),
//       ),
//       body: Container(
//         child: StreamBuilder<User>(
//           stream: _userbloc.userStream,
//           builder: (BuildContext context, AsyncSnapshot<User> snapshot){
//               return Text("");
//           },
//         ),
//       ),
//     );
//   }
// }
