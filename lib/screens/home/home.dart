import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/screens/home/userInfoList.dart';
import 'package:realestate/services/auth.dart';
import 'package:realestate/services/database.dart';


class Home extends StatelessWidget {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userDocumentsStream,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(onPressed:  ()async {await _authService.signOut();},
      icon: Icon(Icons.person),
                label: Text('Sign Out'))


          ],

        ),
        body: UserInfoList(),
      ),
    );
  }
}
