import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/screens/authenticate/authenticate.dart';
import 'package:realestate/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget _widget;

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null){
      _widget =  Authenticate();
    }else{
      _widget =  Home();
    }
    return _widget;
  }
}
