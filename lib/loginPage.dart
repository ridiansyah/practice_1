import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'auth.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({this.onLoggedIn});
  final VoidCallback onLoggedIn;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  bool _loading = false;

  Future _login() async {
    GoAuth auth = new Auth();
    bool status = false;
    await auth.onLogin(_email, _password).then((values) {
      status = values;
      widget.onLoggedIn();
      setState(() {
        _loading = false;
      });
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
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: Text('SIGN UP HERE',
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
                'Silahkan masuk dengan username dan',
                style: new TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ),
            new Center(
              child: new Text(
                'password yang telah terdaftar',
                style: new TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.email),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: "Email",
                ),
                onChanged: (text) {
                  _email = text;
                },
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.lock),
              title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Password",
                  ),
                  obscureText: true,
                  onChanged: (text) {
                    _password = text;
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
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            ),
            new Padding(
              padding: const EdgeInsets.all(3.0),
            ),
            new Center(
              child: new Text(
                '- ATAU -',
                style: new TextStyle(fontSize: 17.0, color: Colors.black),
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
              child: new Text('MASUK DENGAN FACEBOOK',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            ),
            new Padding(
              padding: const EdgeInsets.all(3.0),
            ),
            new Center(
              child: new InkWell(
                child: new Text(
                  'Lupa password ? Buka disini',
                  style: new TextStyle(fontSize: 17.0, color: Colors.black),
                ),
                onTap: () {},
              ),
            )
          ]))
    ]);
  }
}
