import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'dart:math' as Math;

class SanitizeConfirmScreen extends StatelessWidget {
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

  TextEditingController myPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final orderId = Math.Random().nextInt(1000000000);
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    myPriceController.text = vendorPrice.toString();

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: UniversalAppBar(context),
      body: Card(
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  vendorName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  location,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Order ID : $orderId',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  'Current Pricing : $vendorPrice Rs',
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
                      keyboardType: TextInputType.number,
                      controller: myPriceController,
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
                      onPressed: () {
                        if (myPriceController.text.isNotEmpty) {
                          FirebaseFirestore.instance
                              .collection('SanitizerVendorTemp')
                              .doc(uid)
                              .set({
                            'date': DateTime.now().toIso8601String(),
                            'id': orderId,
                            'vPrice': vendorPrice,
                            'name': vendorName,
                            'status': 'open',
                            'cPrice':
                                int.fromEnvironment(myPriceController.text)
                          });
                        } else {
                          scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Please Provide a Price to Bargain'),
                          ));
                        }
                      },
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
                      onPressed: double.parse(vendorPrice.toString()) ==
                              double.parse(myPriceController.text)
                          ? () {
                              print('object');
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
                  'Status - Open',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
