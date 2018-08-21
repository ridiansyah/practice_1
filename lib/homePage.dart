import 'package:flutter/material.dart';
import './dashboardPage.dart' as dashboard;
import './userPage.dart' as user;
import 'auth.dart';

class HomePage extends StatefulWidget{
  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  TabController controller;
  final GoAuth auth = new Auth();

  void _onSignOut() async {
    try {
      bool status = await auth.onSignOut();
      if(status){
        widget.onSignedOut();
      }else{
        print('Cannot SingedOut');
      }
    } catch(e){
      print('Error $e');
    }
  }

  @override
    void initState() {
      controller = new TabController(vsync: this, length: 3);
      super.initState();
    }
  @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
    
  @override
    Widget build(BuildContext context) {
      return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.amber,
        title: new Text("Sistro Mobile"),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new dashboard.DashboardPage(),
          new user.UserPage(
            onSignOut: _onSignOut
          )
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.amber,
        child: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.home),text: "Dashboard",),
            new Tab(icon: new Icon(Icons.person),text: "User"),
          ],
        ),        
      ),
      );
}
}