import 'package:flutter/material.dart';
import 'package:user_app/Models/appbar%20title.dart';
import 'package:user_app/Models/navigation%20titles.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/widgets/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


