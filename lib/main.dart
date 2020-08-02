import 'package:flutter/material.dart';
import 'package:simpleinterestcalculator/app_screens/First_Screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigo,
        brightness: Brightness.dark
      ),
      home: CalculatorScreen(),
    );
  }
}