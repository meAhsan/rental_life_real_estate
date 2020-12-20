import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String title;

  const FormHeader({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          // style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w300),
        ),
        Divider(),
      ],
    );
  }
}