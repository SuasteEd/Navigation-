import 'package:flutter/material.dart';
import 'package:navigation/screens/home_page.dart';
import 'package:navigation/screens/navegar.dart';
import 'package:navigation/screens/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/directions.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigation(),
    );
  }
}
