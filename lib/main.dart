import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'rootPage.dart';
import 'userPage.dart';

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
      home: RootPage(),
      routes: <String, WidgetBuilder>{
        '/user': (BuildContext context) => new UserPage()
      }
    );
  }
}