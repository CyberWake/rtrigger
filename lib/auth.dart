// // import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/services.dart';
// import 'dart:async';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// abstract class BaseAuth {
//   Future<String> loginAndSignin(String email, String password);
//   Future<String> createUserEmailPass(String email, String password);
// }

// class Auth implements BaseAuth {
//   final _auth = FirebaseAuth.instance;
//   Future<String> loginAndSignin(String email, String password) async {
//     AuthResult user = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);

//     return user.user.uid;
//   }

//   Future<String> createUserEmailPass(String email, String password) async {
//     AuthResult user = await _auth.createUserWithEmailAndPassword(
//         email: email, password: password);

//     return user.user.uid;
//   }

//   Future<String> currentUser() async {
//     FirebaseUser user = await FirebaseAuth.instance.currentUser();
//     return user.uid;
//   }
// }



import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;




  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user.user?.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.user?.uid;
  }

  @override
  Future<String> currentUser() async {
    final User user = await _firebaseAuth.currentUser;
    return user?.uid;
  }


  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
