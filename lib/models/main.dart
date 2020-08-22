// import 'package:firebasetut/login_page.dart';
// import 'package:flutter/material.dart';
// import 'auth.dart';
// import 'mainPage.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Firebase Tutorial',
//       theme: ThemeData(
//         primarySwatch: Colors.lightGreen,
//       ),
//       home: MainPage(auth: Auth()),
//     );
//   }
// }



import 'package:flutter/material.dart';
import './auth.dart';
import 'authorizationProvider.dart';
import './mainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
    );
  }
}

