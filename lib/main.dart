import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'loginPage.dart';
import 'signUpPage.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Sistro Mobile',
      theme: new ThemeData(
            primarySwatch: Colors.amber,
            primaryColor: Colors.grey,
            accentColor: Colors.green,
      ),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignUpPage()
      }
    );
  }
}