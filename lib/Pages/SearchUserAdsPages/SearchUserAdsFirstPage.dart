import 'package:flutter/material.dart';

Color firstColor = Colors.deepOrangeAccent;
Color secondColor = Colors.white;
Color thirdColor = Colors.deepPurple;
Color fourthColor = Colors.grey;

class SearchUserAdsFirstPage extends StatefulWidget {
  @override
  _SearchUserAdsFirstPageState createState() => _SearchUserAdsFirstPageState();
}

class _SearchUserAdsFirstPageState extends State<SearchUserAdsFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:firstColor,
        title: Text("Search an Ad"),
      ),
      body: Center(
        child: Text("Searech"),
      ),
    );
  }
}
