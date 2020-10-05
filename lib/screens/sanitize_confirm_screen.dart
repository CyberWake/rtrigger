import 'dart:math' as Math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user/auth/auth.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/models/profile.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';

class SanitizeConfirmScreen extends StatefulWidget {
  final String uid;
  final vendorPrice;
  final double pricePerFeet;
  final Cards category;
  final String vendorName;
  final String location;
  final String phone;

  SanitizeConfirmScreen(
      {@required this.uid,
      @required this.vendorPrice,
      @required this.pricePerFeet,
      @required this.category,
      @required this.vendorName,
      @required this.location,
      @required this.phone});

  @override
  _SanitizeConfirmScreenState createState() => _SanitizeConfirmScreenState();
}

class _SanitizeConfirmScreenState extends State<SanitizeConfirmScreen> {
  final _myPriceTextController = TextEditingController(text: '0');
  final _orderId = Math.Random().nextInt(1000000000);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _collectionName;
  DocumentReference _firestore;
  DocumentReference _firestore1;
  Auth auth = Auth();
  UserProfile profile;
  Razorpay _razorpay;
  bool isLoading = true;
  var time;
  var otp;
  String finalDate = '';

  getCurrentDate() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    finalDate = formattedDate.toString();
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    return await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('An Error occured!'),
              content:
                  Text(response.code.toString() + ' - ' + response.message),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(_).pop();
                  },
                ),
              ],
            ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    String category;
    if (widget.category == Cards.cockroach)
      category = 'Cockroach';
    else if (widget.category == Cards.sanitize)
      category = 'Sanitize';
    else if (widget.category == Cards.mosquito)
      category = 'Mosquito';
    else
      category = 'Others';

//    while (otp.toString().length < 5) {
//      otp = Math.Random().nextInt(100000);
//    }

    var userorders = await FirebaseFirestore.instance
        .collection("userOrders")
        .doc(profile.userId)
        .get();
    print("2");
    List<dynamic> userOrders =
        userorders.data()["orders"] != null ? userorders.data()["orders"] : [];
    print(userOrders);
    print("3");

    userOrders.insert(0, {
      'vendor': widget.vendorName,
      'distance': 0,
      'image': "",
      'id': _orderId.toString(),
      'cid': profile.userId,
      'date': finalDate,
      'customer': profile.username,
      'status': "Successful",
      'otp1': otp,
      'otp2': otp,
      'productID': _orderId.toString(),
      'item': category,
      'price': widget.vendorPrice,
      'quantity': 1
    });
    print("4");
    print(userOrders);

    await _firestore1.set({"orders": userOrders});
    print("5");

    _firestore.set({
      'date': DateTime.now(),
      'id': _orderId,
      'vPrice': widget.vendorPrice,
      'vName': widget.vendorName,
      'status': 'open',
      'vLocation': widget.location,
      'vCategory': category,
      'pricePerFeet': widget.pricePerFeet,
      'cName': profile.username,
      'cMobile': profile.phone,
      'cAddress': profile.address,
      'otp': otp
    });
    print("1");

    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Payment Successful.'),
              content: Text(response.paymentId),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(_).pop();
                  },
                ),
              ],
            ));
  }

  @override
  void initState() {
    getCurrentDate();
    auth.getProfile().whenComplete(() {
      profile = auth.profile;
      setState(() {
        _firestore1 = FirebaseFirestore.instance
            .collection("userOrders")
            .doc(profile.userId);
        isLoading = false;
        time = DateTime.now().millisecondsSinceEpoch.toString().substring(0, 6);
        otp = int.parse(time);
      });
    });
    super.initState();
    _collectionName = 'SanitizerVendorTemp';
    _firestore =
        FirebaseFirestore.instance.collection(_collectionName).doc(widget.uid);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
//test key: rzp_test_Fs6iRWL4ppk5ng
//run key:  rzp_live_LAc1m0adUgWrmv

  Future<void> makePayment() async {
    var options = {
      'key': 'rzp_live_LAc1m0adUgWrmv',
      'amount': widget.vendorPrice * 100, //in paise so * 100
      'name': 'Rtiggers',
      'description': 'Order Payment for id - ' +
          profile.username +
          widget.vendorPrice.toString(),
      'prefill': {'contact': profile.phone.toString(), 'email': profile.email},
      "method": {
        "netbanking": true,
        "card": true,
        "wallet": false,
        "upi": true,
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(context, false, 'Order'),
      key: _scaffoldKey,
      body: WillPopScope(
        onWillPop: () async {
          await _firestore.update({
            'status': 'closed',
          });
          return true;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        child: Text(
                          widget.vendorName + "  OTP: " + otp.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        child: Text(
                          widget.location == null ? 'Unknown' : widget.location,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Text(
                          'Order ID : $_orderId',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Text(
                          'Shop Phone : ${widget.phone}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Text(
                          'Total Price : ${widget.vendorPrice} Rs',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              color: Color.fromRGBO(00, 44, 64, 1.0),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textColor: Colors.white,
                              child: Text('Cancel'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            MaterialButton(
                              color: Color.fromRGBO(00, 44, 64, 1.0),
                              onPressed: () {
                                makePayment();
                                /*String category;
                                if (widget.category == Cards.cockroach)
                                  category = 'Cockroach';
                                else if (widget.category == Cards.sanitize)
                                  category = 'Sanitize';
                                else if (widget.category == Cards.mosquito)
                                  category = 'Mosquito';
                                else
                                  category = 'Others';

                                final time = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString()
                                    .substring(0, 6);
                                final otp = int.parse(time);

                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => PrePayment(
                                              total: widget.vendorPrice,
                                              items: [
                                                {
                                                  'date': DateTime.now(),
                                                  'id': _orderId,
                                                  'vPrice': widget.vendorPrice,
                                                  'vName': widget.vendorName,
                                                  'status': 'open',
                                                  'vLocation': widget.location,
                                                  'vCategory': category,
                                                  'pricePerFeet':
                                                      widget.pricePerFeet,
                                                  'cName': profile.username,
                                                  'cMobile': profile.phone,
                                                  'cAddress': profile.address,
                                                  'otp': otp
                                                }
                                              ],
                                            )));*/
                              },
                              textColor: Colors.white,
                              child: Text('Confirm'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ],
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
}
