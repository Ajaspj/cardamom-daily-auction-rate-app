import 'package:cardamomrate/providers/cardamomdataprovider.dart';
import 'package:cardamomrate/view/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Fetch data in the background
    print("Background fetch task executed");
    await fetchDataInBackground();
    return Future.value(true);
  });
}

Future<void> fetchDataInBackground() async {
  // Implement your background fetch logic here
  // Example: Fetch and save data using CardamomDataProvider
  // Note: You'll need to use a service or other mechanism to ensure this works
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  schedulePeriodicTask();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CardamomDataProvider(),
      child: MyApp(),
    ),
  );
}

void schedulePeriodicTask() {
  Workmanager().registerPeriodicTask(
    "1",
    "fetchData",
    frequency: Duration(minutes: 15), // Adjust as needed
    initialDelay: Duration(seconds: 10), // Adjust if needed
    constraints: Constraints(
      networkType: NetworkType.connected,
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
        brightness: Brightness.light,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
      ),
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
