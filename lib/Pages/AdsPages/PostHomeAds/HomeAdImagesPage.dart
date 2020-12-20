import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeAdImagesPage extends StatefulWidget {
  @override
  _HomeAdImagesPageState createState() => _HomeAdImagesPageState();
}

class _HomeAdImagesPageState extends State<HomeAdImagesPage>
    with AutomaticKeepAliveClientMixin<HomeAdImagesPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(),
    );
  }
}
