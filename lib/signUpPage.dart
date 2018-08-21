import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class SignUpPage extends StatefulWidget {
  SignUpPage({this.onSignedUp});
  final VoidCallback onSignedUp;

  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _name,
      _username,
      _phonenumber,
      _password,
      _confirm_password,
      _birth_date;
  bool _loading = false;
  bool _date_picked;

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  void _onLoading() {
    setState(() {
      _loading = true;
      new Future.delayed(new Duration(seconds: 3), _login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.amber,
        padding: EdgeInsets.all(15.0),
        child: _loading ? progress() : body(),
      ),
      persistentFooterButtons: <Widget>[
        new FlatButton(
            key: null,
            padding: EdgeInsets.all(10.0),
            onPressed: () {},
            child: Text('LOGIN HERE',
                style: new TextStyle(fontSize: 20.0, color: Colors.black)))
      ],
    );
  }

  Widget progress() {
    return Center(
      child: new CircularProgressIndicator(
        value: null,
        strokeWidth: 7.0,
      ),
    );
  }

  Widget body() {
    return ListView(children: <Widget>[
      new Form(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Padding(
                padding: const EdgeInsets.all(30.0),
                child:
                    new Image.asset('assets/logo.png', fit: BoxFit.fitWidth)),
            new Center(
              child: new Text(
                'Daftarkan diri anda sekarang',
                style: new TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.person),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: "Nama Lengkap",
                ),
                onChanged: (text) {
                  _username = text;
                },
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.email),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: "Email",
                ),
                onChanged: (text) {
                  _username = text;
                },
              ),
            ),
            new ListTile(
              onTap: () {},
              leading: const Icon(Icons.phone),
              title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "+62..",
                  ),
                  onChanged: (text) {
                    _password = text;
                  }),
            ),
            new ListTile(
              leading: const Icon(Icons.lock_outline),
              title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Password",
                  ),
                  obscureText: true,
                  onChanged: (text) {
                    _password = text;
                  }),
            ),
            new ListTile(
              leading: const Icon(Icons.lock),
              title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Confirm Password",
                  ),
                  obscureText: true,
                  onChanged: (text) {
                    _confirm_password = text;
                  }),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new MaterialButton(
              key: null,
              color: Colors.black,
              elevation: 4.0,
              splashColor: Colors.amber,
              onPressed: _onLoading,
              child: new Text('MASUK',
                  style: new TextStyle(fontSize: 15.0, color: Colors.white)),
            ),
            new Padding(
              padding: const EdgeInsets.all(3.0),
            ),
            new Center(
              child: new Text(
                '- ATAU -',
                style: new TextStyle(fontSize: 13.0, color: Colors.black),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(3.0),
            ),
            new MaterialButton(
              key: null,
              color: Colors.lightBlue,
              splashColor: Colors.amber,
              onPressed: () {},
              child: new Text('SAMBUNGKAN DENGAN FACEBOOK',
                  style: new TextStyle(fontSize: 15.0, color: Colors.white)),
            )
          ]))
    ]);
  }
}
