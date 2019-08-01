import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_firebase_login/screens/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext context) => new Login()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Login');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset(
              'images/logo.png',
              width: 100,
              height: 100,
              color: Colors.black,
            ),
            /*  decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(90)),
                color: Colors.white),*/
          ),
        ],
      ),
    );
  }
}
