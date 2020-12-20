// // TODO: imports
// // TODO: list of employees
// // TODO: stream controllers
// // TODO: stream sink getter
// // TODO: constructor - add data; listen to changes
// // TODO: core functions
// // TODO: dispose
//
// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'file:///C:/Users/msnk5/StudioProjects/rental_life_real_estate/lib/ModelClasses/UserModelClasses/RentalLifeUser.dart';
//
// class UserBloc {
//   User _user;
//
//   final _userStreamController = StreamController<User>();
//
//   //Stream Controller
//   final _userNameStreamController = StreamController<String>();
//   final _userAgeStreamController = StreamController<int>();
//
//   //Stream getter
//   Stream<User> get userStream => _userStreamController.stream;
//   //Stream sink getter
//   StreamSink<User> get userSink => _userStreamController.sink;
//
//   StreamSink<String> get userNameSink => _userNameStreamController.sink;
//   StreamSink<int> get userAgeSink => _userAgeStreamController.sink;
//
//
//   User get user => _user;
//
//   set user(User value) {
//     _user = value;
//   }
//
//   UserBloc(){
//
//     _userStreamController.add(_user);
//     _userNameStreamController.stream.listen(_updateUserName);
//     _userAgeStreamController.stream.listen(_updateUserAge);
//   }
//
//   _updateUserName(String newName){
//     _user.name = (newName);
//     userSink.add(_user);
//   }
//   _updateUserAge(int newAge){
//     _user.age = (newAge);
//     userSink.add(_user);
//   }
//
//   void disposeAllStreams(){
//     _userStreamController.close();
//     _userNameStreamController.close();
//     _userAgeStreamController.close();
//   }
// }