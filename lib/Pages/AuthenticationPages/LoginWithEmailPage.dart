import 'package:flutter/material.dart';
import 'package:realestate/Service%20Classes/FirebaseUserAuthenticationService.dart';

class LoginWithEmailPage extends StatefulWidget {
  final Function toggleView;

  LoginWithEmailPage({this.toggleView});

  @override
  _LoginWithEmailPageState createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginWithEmailPage> {
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  final FirebaseUserAuthenticationService _authService = FirebaseUserAuthenticationService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Icons.email,
                    color: Colors.blueGrey,
                  ),
                  hintText: "Enter email",
                  border: OutlineInputBorder(),
                ),
                validator: ((val) => val.isEmpty ? 'Enter an email' : null),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.lock,
                    color: Colors.blueGrey,
                  ),
                  hintText: "Enter password",
                  border: OutlineInputBorder(),
                ),
                validator: ((val) => val.length < 6
                    ? 'Enter a password atleast 6 characters long'
                    : null),
                onChanged: (val) {
                  setState(() {
                    password = val;
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
                child: Text("Login"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result =
                    await _authService.signInWithEmail(email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        return error =
                        'Invalid credentials. Could not sign it.';
                      });
                    }
                  }
                },
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              )
            ],
          ),
        ));
  }
}

