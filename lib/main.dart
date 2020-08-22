import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user/screens/home_screen.dart';
import 'package:user/screens/navigating_home_screen.dart';
import 'package:user/widgets/homedrawer.dart';

import 'auth.dart';
import 'authorizationProvider.dart';
import 'mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
        auth: Auth(),
    child: MaterialApp(
    theme: ThemeData(
    primarySwatch: Colors.blue,
    ),
    home: RootPage(),
    ),
  }
}