import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new ListView(
      children: <Widget>[
        new Image.asset('assets/pict_home_1.png', fit: BoxFit.fitWidth),
        new Image.asset('assets/pict_home_2.png', fit: BoxFit.fitWidth),
        new Image.asset('assets/pict_home_3.png', fit: BoxFit.fitWidth),
      ],
    ));
  }
}
