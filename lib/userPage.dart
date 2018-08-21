import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserPage extends StatefulWidget {
  UserPage({this.onSignOut});
  final VoidCallback onSignOut;

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<UserPage> {
  String _username;

  void _submitToSignOut() async {
    try {
      await Navigator.pop(context);
      widget.onSignOut();
    } catch (e) {
      print('Error $e');
    }
  }

  void _dialogSubmitSignOut(value) {
    AlertDialog dialog = new AlertDialog(
      content: new Text(
        value,
        style: new TextStyle(fontSize: 14.0),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: _submitToSignOut,
          child: new Text('Ya'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('Tidak'),
        )
      ],
    );

    showDialog(context: context, child: dialog);
  }

  List<Widget> setCard(bool status) {
    if (status) {
      return [
        new Card(
          child: Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              new Row(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new Icon(Icons.person, size: 100.0),
                  new Padding(
                    padding: const EdgeInsets.all(5.0),
                  ),
                  new Text(
                    _username,
                    style: new TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              new MaterialButton(
                minWidth: 380.0,
                color: Colors.red,
                elevation: 4.0,
                splashColor: Colors.amber,
                onPressed: () {
                  _dialogSubmitSignOut('Apakah anda yakin melakukan Logout');
                },
                child: new Text('Keluar',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
              ),
            ],
          ),
        )
      ];
    } else {
      return [];
    }
  }

  Future<bool> _setContent() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();

    try {
      // await storage.read(key: 'token').then((token) {
      //   http.get(
      //       "http://sistrodev.petrokimia-gresik.com/api/Account/DetailUser",
      //       headers: {'Authorization': token}).then((response) {
      //     var body = response.body;
      //     var decoded = json.decode(body);
          setState(() {
            _username = 'nugi';
          });
      //   });
      // });
      return true;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        future: _setContent(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Center(child: new Text('Loading...'));
            default:
              if (snapshot.hasError)
                return new Center(child: new Text('Error Connection'));
              else {
                return new ListView(
                  children: <Widget>[
                    new Container(
                        child: new Column(
                      children: setCard(snapshot.data),
                    ))
                  ],
                );
              }
          }
        });
    return Scaffold(body: futureBuilder);
  }
}
