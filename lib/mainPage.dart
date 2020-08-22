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
import './auth.dart';
import './homePage.dart';
import './login_page.dart';
import 'authorizationProvider.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;

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

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();
      case AuthStatus.notSignedIn:
        return LoginPage(
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return HomePage(
          onSignedOut: _signedOut,
        );
    }
    return null;
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
