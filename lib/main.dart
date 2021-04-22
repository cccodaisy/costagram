import 'package:flutter/material.dart';
import 'package:costagram/home_page.dart';
import 'package:costagram/constants/material_white.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primarySwatch: white)
    );
  }
}