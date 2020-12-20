import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeAdDescriptionPage extends StatefulWidget {
  final GlobalKey<FormState> _formKey;

  HomeAdDescriptionPage(this._formKey);

  @override
  _HomeAdDescriptionPageState createState() => _HomeAdDescriptionPageState();
}

class _HomeAdDescriptionPageState extends State<HomeAdDescriptionPage>
    with AutomaticKeepAliveClientMixin<HomeAdDescriptionPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Form(
          // onChanged: _onFormChange,
          // onWillPop: _onWillPop,
          key: widget._formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                // initialValue: widget._rentalLifeUser.name,//_name,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // autofocus: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.drive_file_rename_outline,
                    color: Colors.blueGrey,
                  ),
                  labelText: "Name ",
                  hintText: "Required",
                  border: OutlineInputBorder(),
                ),
                validator: ((val) {
                  if (val.length < 3) {
                    return 'Name too short';
                  } else if (val.length > 15) {
                    return 'Name too long';
                  }
                  return null;
                }),
                onChanged: (val) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
