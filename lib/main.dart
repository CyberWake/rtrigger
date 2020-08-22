import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'auth/auth.dart';
import 'auth/authorizationProvider.dart';
import 'screens/root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ));
  }
}
