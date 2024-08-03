import 'package:cardamomrate/providers/cardamomdataprovider.dart';
import 'package:cardamomrate/view/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CardamomDataProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light, // Light theme
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Dark theme
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
      ),
      themeMode: ThemeMode.system, // Follow system theme
      home: SplashScreen(),
    );
  }
}
