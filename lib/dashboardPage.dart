import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: new Column(
          children: <Widget>[
            new Image.asset(
              'assets/logo.png',
              fit: BoxFit.fitWidth,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Text(
                'SISTRO merupakan aplikasi operasional distribusi pada PT Petrokimia Gresik, dengan beberapa fitur unggulan seperti penjadwalan pemuatan truk, tracking armada pemuatan, dan pencetakan tiket muat.',
                textAlign: TextAlign.center,
                style: new TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
