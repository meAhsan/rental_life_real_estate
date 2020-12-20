import 'package:flutter/material.dart';
import 'package:realestate/Service%20Classes/FirebaseUserAuthenticationService.dart';
import 'package:realestate/shared/loading.dart';

class RegisterWithEmailPage extends StatefulWidget {
  final Function toggleView;

  RegisterWithEmailPage({this.toggleView});

  @override
  _RegisterWithEmailPageState createState() => _RegisterWithEmailPageState();
}

class _RegisterWithEmailPageState extends State<RegisterWithEmailPage> {
  final FirebaseUserAuthenticationService _authService = FirebaseUserAuthenticationService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //text field state
  String email = '';
  String firstName = '';
  String lastName = '';
  String password = '';
  String confirmPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
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
              /*Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[*/
              // TextFormField(
              //   decoration: InputDecoration(
              //     hintText: "First Name",
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: ((val) =>
              //   val.isEmpty ? 'First Name is mandatory' : null),
              //   onChanged: (val) {
              //     setState(() {
              //       firstName = val;
              //     });
              //   },
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     hintText: "Last Name",
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: ((val) =>
              //   val.isEmpty ? 'Last Name is mandatory' : null),
              //   onChanged: (val) {
              //     setState(() {
              //       lastName = val;
              //     });
              //   },
              // ),
              // /*],
              //     ),*/
              // SizedBox(
              //   height: 10,
              // ),
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
                height: 10,
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
                    ? 'Password should be at least 6 characters long.'
                    : null),
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.lock,
                    color: Colors.blueGrey,
                  ),
                  hintText: "Confirm password",
                  border: OutlineInputBorder(),
                ),
                validator: ((val) => val.compareTo(password)==0
                    ? null
                    : 'Passwords mismatched'),
                onChanged: (val) {
                  setState(() {
                    confirmPassword = val;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text("Signup"),
                onPressed: () async {
                  // print(email);
                  // print(password);
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    // String name = firstName + " " + lastName;
                    // print("NAME: (________________): " + name);
                    dynamic result = await _authService.registerWithEmail(
                        email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        return error = 'Please supply a valid email id';
                      });
                    }
                  }
                },
              ),
              SizedBox(
                height: 0,
              ),
              Center(
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ],
          ),
        ));
  }
}