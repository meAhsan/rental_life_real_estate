import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/AdInfo.dart';
import 'package:realestate/screens/home/ads_List.dart';
import 'package:realestate/screens/home/user_List.dart';
import 'package:realestate/services/ads_firestore_service.dart';

class AdsFeed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<AdData>>.value(
      value: AdsFirestoreService().adsDocumentsStream,
      child: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Ads'),
          backgroundColor: Colors.red[600],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Sign Out')),
            FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('settings')),
          ],
        ),
        body: AdsInfoList(),
      ),
    );
  }
}
