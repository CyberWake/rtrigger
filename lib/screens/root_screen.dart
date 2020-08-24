// import 'package:flutter/material.dart';
// import 'login_page.dart';
// import 'auth.dart';

// class MainPage extends StatefulWidget {
//   MainPage({this.auth});
//   final BaseAuth auth;

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// enum AuthStatus {
//   notSignedIn,
//   singedIn,
// }

// class _MainPageState extends State<MainPage> {
//   AuthStatus authStatus = AuthStatus.notSignedIn;

//   initState() {
//     super.initState();
//     widget.auth.currentUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (authStatus) {
//       case AuthStatus.notSignedIn:
//         return LoginPage(
//           auth: widget.auth,
//         );
//       case AuthStatus.singedIn:
//         return Container(
//           child: Text('Welcome'),
//         );
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:user/screens/home_screen.dart';
import 'package:user/screens/navigating_home_screen.dart';
import 'package:user/models/varialbes.dart';
import 'package:user/widgets/homedrawer.dart';
import '../auth/auth.dart';
import '../auth/authorizationProvider.dart';
import 'login_signup_screen.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final BaseAuth auth = AuthProvider.of(context).auth;
    auth.currentUser().then((String userId) {
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  /*void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return LoginSignupPage(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return NavigationHomeScreen();
    }
    return _buildWaitingScreen();
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
  }
}
