import 'package:flutter/material.dart';
import 'authPage.dart';
import 'auth.dart';
import 'homePage.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  onLoading,
  notSignedIn,
  loggedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.onLoading;
  final GoAuth auth = new Auth();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      if (auth != null) {
        auth.onLoggedIn().then((status) {
          setState(() {
            authStatus = status
                ? AuthStatus.loggedIn
                : AuthStatus.notSignedIn;
          });
        });
      } else {
        authStatus = AuthStatus.notSignedIn;
      }
    } catch (e) {
        print(e);
        authStatus = AuthStatus.notSignedIn;
    }
  }

  void _loggedIn() {
    setState(() {
      authStatus = AuthStatus.loggedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.onLoading:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return AuthPage(
          onLoggedIn: _loggedIn,
        );
      case AuthStatus.loggedIn:
        return HomePage(
          onSignedOut: _signedOut,
        );
    }
    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
