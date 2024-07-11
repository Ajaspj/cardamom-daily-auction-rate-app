import 'package:cardamomrate/view/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cardamom Data',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: SplashScreen());
  }
}
