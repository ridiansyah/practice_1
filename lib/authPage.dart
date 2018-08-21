import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthPage extends StatefulWidget {
  AuthPage({this.onLoggedIn});
  final VoidCallback onLoggedIn;

  @override
  _AuthPageState createState() => new _AuthPageState();
}

enum AuthStatus {
  onLoginPage,
  onSignUpPage,
  onForgotPasswordPage,
  onSubmitConfirm
}

class _AuthPageState extends State<AuthPage> {
  String _name, _email, _password, _phonenumber, _birth_date, _confirm_password;
  AuthStatus authStatus;
  FlutterSecureStorage storage = new FlutterSecureStorage();

  bool _loading = false;

  void didChangedDepedencies() {
    super.didChangeDependencies();
    storage.read(key: 'confirm').then((value) {
      if (value != null) {
        setState(() {
          authStatus = AuthStatus.onSubmitConfirm;
        });
      } else {
        setState(() {
          authStatus = AuthStatus.onLoginPage;
        });
      }
    });
  }

  void _goPage(String page) {
    setState(() {
      switch (page) {
        case 'login':
          setState(() {
            authStatus = AuthStatus.onLoginPage;
          });
          break;
        case 'signup':
          setState(() {
            authStatus = AuthStatus.onSignUpPage;
          });
          break;
        case 'forgotpassword':
          setState(() {
            authStatus = AuthStatus.onForgotPasswordPage;
          });
          break;
        case 'submit_confirm':
          setState(() {
            authStatus = AuthStatus.onSubmitConfirm;
          });
      }
    });
  }

  Future _loginProccess() async {
    try {
      GoAuth auth = new Auth();
      await auth
          .onSignUp(_name, _phonenumber, _email, _password, _birth_date)
          .then((values) {
        widget.onLoggedIn();
        setState(() {
          _loading = false;
        });
      });
    } catch (err) {}
  }

  Future _signUpProccess() async {
    GoAuth auth = new Auth();
    await auth
        .onSignUp(_name, _phonenumber, _email, _password, _birth_date)
        .then((values) {
      setState(() {
        authStatus = AuthStatus.onLoginPage;
        _loading = false;
      });
    });
  }

  Future _forgotPasswordProccess() async {
    GoAuth auth = new Auth();
    await auth.onForgotPassword(_email).then((values) {
      setState(() {
        _loading = false;
      });
    });
  }

  void _onLoading(AuthStatus authStatus) {
    setState(() {
      _loading = true;
      if (authStatus == AuthStatus.onLoginPage) {
        new Future.delayed(new Duration(seconds: 3), _loginProccess);
      } else if (authStatus == AuthStatus.onSignUpPage) {
        new Future.delayed(new Duration(seconds: 3), _signUpProccess);
      } else if (authStatus == AuthStatus.onForgotPasswordPage) {
        new Future.delayed(new Duration(seconds: 3), _forgotPasswordProccess);
      } else {
        new Future.delayed(new Duration(seconds: 3), _loginProccess);
      }
    });
  }

  Widget _pageBodyController(AuthStatus authStatus) {
    switch (authStatus) {
      case (AuthStatus.onLoginPage):
        return loginBody();
        break;
      case (AuthStatus.onSignUpPage):
        return signUpBody();
        break;
      case (AuthStatus.onForgotPasswordPage):
        return forgotPasswordBody();
        break;
      default:
        return loginBody();
        break;
    }
  }

  Widget _pageFooterController(AuthStatus authStatus) {
    switch (authStatus) {
      case (AuthStatus.onLoginPage):
        return loginFooter();
        break;
      case (AuthStatus.onSignUpPage):
        return signUpFooter();
        break;
      case (AuthStatus.onForgotPasswordPage):
        return forgotPasswordFooter();
        break;
      default:
        return loginFooter();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            color: Colors.amber,
            padding: EdgeInsets.all(15.0),
            child: _loading ? progress() : _pageBodyController(authStatus)),
        bottomNavigationBar:
            _loading ? null : _pageFooterController(authStatus));
  }

  Widget progress() {
    return Center(
      child: new CircularProgressIndicator(
        value: null,
        strokeWidth: 7.0,
      ),
    );
  }

  Widget forgotPasswordFooter() {
    return new Material(
        color: Colors.redAccent,
        child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new InkWell(
                splashColor: Colors.redAccent,
                onTap: () {
                  _goPage('signup');
                },
                child: new Text('Belum punya akun ? SIGN UP HERE',
                    textAlign: TextAlign.center))));
  }

  Widget signUpFooter() {
    return new Material(
        color: Colors.redAccent,
        child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new InkWell(
                splashColor: Colors.redAccent,
                onTap: () {
                  _goPage('login');
                },
                child: new Text('Sudah punya akun ? LOGIN HERE',
                    textAlign: TextAlign.center))));
  }

  Widget loginFooter() {
    return new Material(
        color: Colors.redAccent,
        child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new InkWell(
                splashColor: Colors.redAccent,
                onTap: () {
                  _goPage('signup');
                },
                child: new Text('Belum punya akun ? SIGN UP HERE',
                    textAlign: TextAlign.center))));
  }

  Widget forgotPasswordBody() {
    return ListView(children: <Widget>[
      new Form(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, top: 30.0, bottom: 10.0, right: 30.0),
                child:
                    new Image.asset('assets/logo.png', fit: BoxFit.fitWidth)),
            new Center(
              child: new Text(
                'Masukan email mu yang sudah terdaftar',
                style: new TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ),
            new Padding(padding: const EdgeInsets.all(10.0)),
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
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new MaterialButton(
              key: null,
              color: Colors.black,
              elevation: 4.0,
              splashColor: Colors.amber,
              onPressed: () {
                _onLoading(authStatus);
              },
              child: new Text('MASUK',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            )
          ]))
    ]);
  }

  Widget signUpBody() {
    return ListView(children: <Widget>[
      new Form(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, top: 30.0, bottom: 10.0, right: 30.0),
                child:
                    new Image.asset('assets/logo.png', fit: BoxFit.fitWidth)),
            new Center(
              child: new Text(
                'Daftarkan diri anda sekarang',
                style: new TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ),
            new Padding(padding: const EdgeInsets.all(10.0)),
            new ListTile(
              leading: const Icon(Icons.person),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: "Nama Lengkap",
                ),
                onChanged: (text) {
                  _name = text;
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
                  _email = text;
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
                    _phonenumber = text;
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
              onPressed: () {
                _onLoading(authStatus);
              },
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

  Widget loginBody() {
    return ListView(children: <Widget>[
      new Form(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, top: 30.0, bottom: 10.0, right: 30.0),
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
            new Padding(padding: const EdgeInsets.all(10.0)),
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
              onPressed: () {
                _onLoading(authStatus);
              },
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
                onTap: () {
                  _goPage('forgotpassword');
                },
              ),
            )
          ]))
    ]);
  }
}
