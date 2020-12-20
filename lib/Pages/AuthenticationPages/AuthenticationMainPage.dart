import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realestate/Service%20Classes/FirebaseUserAuthenticationService.dart';
import 'package:realestate/shared/loading.dart';

import 'LoginWithEmailPage.dart';
import 'RegisterWithEmailPage.dart';

class AuthenticationMainPage extends StatefulWidget {
  @override
  _AuthenticationMainPageState createState() => _AuthenticationMainPageState();
}

class _AuthenticationMainPageState extends State<AuthenticationMainPage> {
  final FirebaseUserAuthenticationService _authService =
      FirebaseUserAuthenticationService();

  final String backImg = "image_assets/welcome_screen_bg.jpg";
  bool formVisible;
  int _formsIndex;
  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImg),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.black54,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: kToolbarHeight + 40),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Welcome",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              "Welcome to Rental Life\nReal Estate Chapter.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: RaisedButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text("Login"),
                              onPressed: () {
                                setState(() {
                                  formVisible = true;
                                  _formsIndex = 1;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: RaisedButton(
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text("Signup"),
                              onPressed: () {
                                setState(() {
                                  formVisible = true;
                                  _formsIndex = 2;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      OutlineButton.icon(
                        borderSide: BorderSide(color: Colors.red),
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        icon:
                            Icon(FontAwesomeIcons.google, color: Colors.amber),
                        label: Text("Continue with Google"),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _authService.signInWithGoogle();
                          if (result == null) {
                            setState(() {
                              loading = false;
                              return error =
                                  'Invalid credentials. Could not sign it.';
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: (!formVisible)
                      ? null
                      : Container(
                          color: Colors.black54,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    textColor: _formsIndex == 1
                                        ? Colors.white
                                        : Colors.black,
                                    color: _formsIndex == 1
                                        ? Colors.red
                                        : Colors.white,
                                    child: Text("Login"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      setState(() {
                                        _formsIndex = 1;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10.0),
                                  RaisedButton(
                                    textColor: _formsIndex == 2
                                        ? Colors.white
                                        : Colors.black,
                                    color: _formsIndex == 2
                                        ? Colors.red
                                        : Colors.white,
                                    child: Text("Signup"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      setState(() {
                                        _formsIndex = 2;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10.0),
                                  IconButton(
                                    color: Colors.white,
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        formVisible = false;
                                      });
                                    },
                                  )
                                ],
                              ),
                              Container(
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: _formsIndex == 1
                                      ? LoginWithEmailPage()
                                      : RegisterWithEmailPage(),
                                ),
                              )
                            ],
                          ),
                        ),
                )
              ],
            ),
          ));
  }
}
