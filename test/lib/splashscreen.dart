
import 'package:flutter/material.dart';

import 'package:splashscreen/splashscreen.dart';

import 'package:test/home.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text('Classifier test',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.yellowAccent
          ),
        ),
        image: Image.asset('Assets/ye.png'),
        backgroundColor: Colors.blueAccent,
        photoSize: 60,
        loaderColor: Colors.redAccent,
    );
  }
}