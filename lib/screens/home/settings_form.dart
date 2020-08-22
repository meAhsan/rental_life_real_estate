import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/services/database.dart';
import 'package:realestate/shared/constants.dart';
import 'package:realestate/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

List<int> createAgeArray() {
  List<int> age = new List();
  for (int i = 10; i <= 100; i++) {
    age.add(i);
  }
  return age;
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<int> age = createAgeArray();

  String _currentName;
  String _currentPhoneNumber;
  int _currentAge;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserDocumentData>(
        stream: DatabaseService(uid: user.uid).userDataDocument,
        builder: (context, snapshot) {
          //Snapshot here is not from firebase, it is data coming down the stream.
          if (snapshot.hasData) {
            UserDocumentData userDocumentData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your Info',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userDocumentData.name ?? 'Name',
                    decoration: textInputDecorationForString,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecorationForString,
                    value: _currentAge ?? 15,
                    items: age.map((a) {
                      return DropdownMenuItem(
                        value: a,
                        child: Text('Age: $a'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentAge = val),
                  ),
                  //slider
                  Slider(
                    value: (_currentAge ?? 10).toDouble(),
                    activeColor: Colors.blue[_currentAge ?? 100],
                    inactiveColor: Colors.blue[_currentAge ?? 100],
                    min: 10,
                    max: 100,
                    divisions: 85,
                    onChanged: (val) =>
                        setState(() => _currentAge = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      print(_currentName);
                      print(_currentPhoneNumber);
                      print(_currentAge);
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}