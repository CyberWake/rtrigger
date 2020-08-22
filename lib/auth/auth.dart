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
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user?.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user?.uid;
  }

  @override
  Future<String> currentUser() async {
    final User user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  Future<void> addUserDetails(String email, String username, String uid) async {
    var auth1 = FirebaseFirestore.instance;
    var _db = auth1.collection('users').doc(uid);
    _db.set({
      'username': username,
      'email': email,
      'userId': uid,
      'phone': 9999999999,
      'address': "Address",
      'imageUrl':
          "https://icon-library.com/images/default-user-icon/default-user-icon-4.jpg"
    });
  }

  Future<void> getProfile() async {
    final User user = _firebaseAuth.currentUser;
    var auth1 = FirebaseFirestore.instance;
    var profile = auth1.collection('users').doc(user.uid).get().then((value) {
      return value.data();
    });
    return profile;
  }

  Future<void> updateProfile(
      {String email,
      String username,
      String uid,
      int phone,
      String address,
      String url}) async {
    final User user = _firebaseAuth.currentUser;
    var auth1 = FirebaseFirestore.instance;
    var _db = auth1.collection('users').doc(user.uid);
    _db.update({
      'username': username,
      'email': email,
      'userId': uid,
      'phone': phone,
      'address': address,
      'imageUrl': url
    }).then((value) {
      return "Success";
    }).catchError(() {
      return "cannot add";
    });
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
