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
      {@required this.name,
      @required this.location,
      @required this.url,
      @required this.description,
      @required this.uid});

  @override
  _MedicalBargainScreenState createState() => _MedicalBargainScreenState();
}

class _MedicalBargainScreenState extends State<MedicalBargainScreen> {
  final _collectionName = 'MedicalTemp';
  final _orderNo = Math.Random().nextInt(10000000000);

  @override
  Widget build(BuildContext context) {
    print(_orderNo);
    return Scaffold();
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
