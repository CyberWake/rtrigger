import 'package:flutter/material.dart';
import 'package:user/auth/auth.dart';
import 'package:user/models/profile.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SaloonServiceListTile extends StatefulWidget {
  final String service;
  final price;

  SaloonServiceListTile(this.service, this.price);

  @override
  _SaloonServiceListTileState createState() => _SaloonServiceListTileState();
}

class _SaloonServiceListTileState extends State<SaloonServiceListTile> {
  Auth auth = Auth();
  UserProfile profile;
  Razorpay _razorpay;
  bool isLoading = true;

  void _handlePaymentError() async {
    return await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('An Error occured!'),
          content: Text('Something went Wrong'),
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

  void _handleExternalWallet() {
    return;
  }

  void _handlePaymentSuccess() async {
    return await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Hurray!'),
          content: Text('Payment Successful.'),
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
    auth.getProfile().whenComplete(() {
      profile = auth.profile;
      setState(() {
        isLoading = false;
      });
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  Future<void> makePayment() async {
    var options = {
      'key': 'rzp_test_Fs6iRWL4ppk5ng',
      'amount': widget.price*100, //in paise so * 100
      'name': 'Rtiggers',
      'description':
      'Order Payment for id - ' + profile.username + widget.price.toString(),
      'prefill': {'contact': profile.phone, 'email': profile.email},
      "method": {
        "netbanking": true,
        "card": true,
        "wallet": true,
        "upi": true,
      },
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
        elevation: 7,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.service,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.price.toString() + ' Rs'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                elevation: 4,
                color: Color.fromRGBO(00, 44, 64, 1.0),
                textColor: Colors.white,
                height: screenHeight / 24,
                onPressed: () {
                  makePayment();
                },
                child: Text('Book Now'),
              ),
            )
          ],
        ));
  }
}