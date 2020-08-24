import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'dart:math' as Math;

import 'package:user/widgets/loading_bar.dart';

class SanitizeConfirmScreen extends StatefulWidget {
  final String uid;
  final vendorPrice;
  final pricePerFeet;
  final Cards category;
  final String vendorName;
  final String location;

  SanitizeConfirmScreen(
      {@required this.uid,
      @required this.vendorPrice,
      @required this.pricePerFeet,
      @required this.category,
      @required this.vendorName,
      @required this.location});

  @override
  _SanitizeConfirmScreenState createState() => _SanitizeConfirmScreenState();
}

class _SanitizeConfirmScreenState extends State<SanitizeConfirmScreen> {
  String myPriceText = '0';
  final orderId = Math.Random().nextInt(1000000000);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final String collectionName = 'SanitizerVendorTemp';
  String changedPrice = '';
  String status = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: WillPopScope(
        onWillPop: () async {
          FirebaseFirestore.instance
              .collection(collectionName)
              .doc(widget.uid)
              .update({
            'status': 'closed',
          });
          return true;
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(collectionName)
                              .doc(widget.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return LoadingBar();
                            } else {
                              status = snapshot.data.data()['status'].toString();
                              changedPrice =
                                  snapshot.data.data()['vPrice'].toString();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 8),
                                    child: Text(
                                      snapshot.data.data()['name'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 8),
                                    child: Text(
                                      snapshot.data.data()['location'] == null
                                          ? 'Unknown'
                                          : snapshot.data.data()['location'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Order ID : ${snapshot.data.data()['id']}',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    child: Text(
                                      'Current Price : ${snapshot.data.data()['vPrice']} Rs',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Text(
                          myPriceText.isEmpty
                              ? 'Your Price : 0 Rs'
                              : 'Your Price : $myPriceText Rs',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Your Price - Rs',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  myPriceText = value;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  focusColor: Color.fromRGBO(00, 44, 64, 1.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)))),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            MaterialButton(
                              textColor: Colors.white,
                              color: Color.fromRGBO(00, 44, 64, 1.0),
                              onPressed: myPriceText.toString() !=
                                          changedPrice.toString() &&
                                      myPriceText != '0'
                                  ? () {
                                      if (myPriceText.isNotEmpty) {
                                        FirebaseFirestore.instance
                                            .collection(collectionName)
                                            .doc(widget.uid)
                                            .update({
                                          'cPrice': double.tryParse(myPriceText),
                                        });
                                        Navigator.of(context).pop();
                                      } else {
                                        scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Please Enter a Price to Bargain'),
                                        ));
                                      }
                                    }
                                  : null,
                              child: Text(
                                'Bargain',
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            MaterialButton(
                              color: Color.fromRGBO(00, 44, 64, 1.0),
                              onPressed: changedPrice.toString() == myPriceText
                                  ? () {
                                      // todo : Implement Payment
                                    }
                                  : null,
                              textColor: Colors.white,
                              child: Text('Accept'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Status - $status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection(collectionName).doc(widget.uid).set({
      'date': DateTime.now(),
      'id': orderId,
      'vPrice': widget.vendorPrice,
      'name': widget.vendorName,
      'status': 'open',
      'location': widget.location,
    });
  }
}
