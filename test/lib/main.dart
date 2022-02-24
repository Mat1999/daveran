// @dart=2.9
import 'package:flutter/material.dart';
import 'package:test/splashscreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classifier Test',
      home: MySplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
