import 'package:cardamomrate/view/homescreen/homescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CardamomScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Image.asset(
          "assets/images/cdmlogo.png",
          scale: 1.0,
          color: theme.colorScheme.onSurface,
          colorBlendMode: BlendMode.modulate,
        ),
      ),
    );
  }
}
