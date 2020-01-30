import 'package:cycle_of_life/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cycle of Life',
      theme: ThemeData(fontFamily: 'Raleway'),
      // home: HomeScreen(),
      home: HomeScreen(),
    );
  }
}