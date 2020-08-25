import 'package:flutter/material.dart';
import 'package:realestate/screens/ads/image_capture.dart';
import 'package:realestate/screens/home/bottom_navigation_bar.dart';

class PostAd extends StatefulWidget {
  @override
  _PostAdState createState() => _PostAdState();
}

class _PostAdState extends State<PostAd> {
  @override
  Widget build(BuildContext context) {
    return PostAdInfo();
  }
}

class PostAdInfo extends StatefulWidget {
  final String adTitle;
  final String adDescription;

  PostAdInfo({this.adTitle, this.adDescription});

  @override
  _PostAdInfoState createState() => _PostAdInfoState();
}

class _PostAdInfoState extends State<PostAdInfo> {
  bool loading = false;

  //text field state
  String title = '';
  String desc = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red[600],
          centerTitle: true,
          title: Column(children: [
            Text(
              "Post an Ad",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            GestureDetector(
              child: Text(
                "Update Ad Info",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 17,
                ),
              ),
            )
          ]),
        ),
        body: Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.title,
                        color: Colors.blueGrey,
                      ),
                      hintText: "Ad Title",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) =>
                    (val.length <= 5 || val.length >= 18)
                        ? 'Title should range within 5 to 18 letters.'
                        : null),
                    onChanged: (val) {
                      setState(() {
                        //email = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.description,
                        color: Colors.blueGrey,
                      ),
                      hintText: "Ad Description",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) =>
                    (val.length <= 10 || val.length >= 180)
                        ? '*Description should range within 10 to 180 letters.'
                        : null),
                    onChanged: (val) {
                      setState(() {
                        //password = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text("Next"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigationWidget()),
                          );*/
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageCapture()),
                          );
                        }
                      }

                  ),
                ],
              ),
            )));
  }
}
