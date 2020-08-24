import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class MedicalBargainScreen extends StatefulWidget {
  final String uid;
  final String name;
  final String location;
  final String url;
  final String description;

  MedicalBargainScreen(
      { this.name,
        this.uid,
        this.location,
        this.url,
        this.description});

  @override
  _MedicalBargainScreenState createState() => _MedicalBargainScreenState();
}

class _MedicalBargainScreenState extends State<MedicalBargainScreen> {
  final _collectionName = 'MedicalTemp';
  final _orderNo = Math.Random().nextInt(1000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Text(_orderNo.toString(),style: TextStyle(color: Colors.black),),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(widget.uid)
        .set({});
  }
}
