import 'package:flutter/material.dart';
import 'package:realestate/Pages/SettingsPages/FormFieldContainer.dart';

class UserProfileForm extends StatefulWidget {
  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  // UserBloc _bloc;
  bool _userInformationHasBeenUpdated = false;
  String _prevName;
  String _prevContact;
  //
  // @override
  // void didChangeDependencies() async {
  //
  //   super.didChangeDependencies();
  // }
  //
  // void onChangeName() {
  //   if (_prevName == _nameController.text && _prevContact == _emailController.text) return;
  //   setState(() {
  //     _userInformationHasBeenUpdated = true;
  //   });
  // }
  //
  // void onChangeEmail() {
  //   if (_prevName == _nameController.text && _prevContact == _emailController.text) return;
  //   setState(() {
  //     _userInformationHasBeenUpdated = true;
  //   });
  // }

  FlatButton get submitButton => FlatButton(
    onPressed: _userInformationHasBeenUpdated
        ? () {
      // _bloc.updateUserInformationSink.add(
      //   UpdateUserEvent(
      //     ECommerceUser(name: _nameController.text, contact: _emailController.text),
      //   ),
      // );
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         content: Text(
      //             "Submitted Name: ${_nameController.text}, Submitted Contact: ${_emailController.text}"),
      //       );
      //     });
    }
        : null,
    child: Text("Submit info"),
  );

  @override
  Widget build(BuildContext context) {
    Widget avatar = Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/apple-in-hand.jpg"),
          radius: 60.0,
        ));

    return Column(
      children: <Widget>[
        avatar,
        FormFieldContainer(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name:",
            ),
            controller: _nameController,
          ),
        ),
        FormFieldContainer(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Contact:",
            ),
            controller: _emailController,
          ),
        ),
        submitButton,
      ],
    );
  }
}