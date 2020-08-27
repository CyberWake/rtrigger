import 'dart:math' as Math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user/auth/auth.dart';
import 'package:user/models/apptheme.dart';
import 'package:user/models/profile.dart';

class PrePayment extends StatefulWidget {
  final int total;

  const PrePayment({this.total});

  @override
  _PrePaymentState createState() => _PrePaymentState();
}

class _PrePaymentState extends State<PrePayment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Auth auth = Auth();
  UserProfile profile;
  Razorpay _razorpay;
  bool isLoading = true;
  String address;
  int phoneno;
  int _orderNo;

  void _handlePaymentError(PaymentFailureResponse response) async {
    await showDialog(
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
    auth.getProfile().whenComplete(() {
      profile = auth.profile;
      address = profile.address;
      phoneno = profile.phone;
      _orderNo = Math.Random().nextInt(100000000);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> makePayment() async {
    var options = {
      'key': 'rzp_test_Fs6iRWL4ppk5ng',
      'amount': widget.total * 100, //in paise so * 100
      'name': 'Rtiggers',
      'description': 'Order Payment for id - #' + _orderNo.toString(),
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

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void validateAndSave() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
          await geolocator.checkGeolocationPermissionStatus();
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position);
      makePayment();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Order Details",
          style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Customer Name: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Spacer(),
                            Flexible(
                                child: Text(
                              profile.username,
                              style: TextStyle(fontSize: 18),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Order ID: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Spacer(),
                            Text(
                              '#' + _orderNo.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Total Amount: ",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              '₹ ' + widget.total.toString(),
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            decoration: InputDecoration(labelText: 'Address'),
                            initialValue: address,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.multiline,
                            onSaved: (value) {
                              address = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid address.';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            decoration: InputDecoration(labelText: 'Phone'),
                            initialValue: phoneno.toString(),
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              phoneno = int.parse(value);
                            },
                            validator: (value) {
                              if (value.isEmpty ||
                                  int.parse(value) < 6000000000 ||
                                  int.parse(value) > 9999999999) {
                                return 'Please enter valid phone number';
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppTheme.dark_grey,
        elevation: 5,
        child: Container(
          child: FloatingActionButton.extended(
            splashColor: AppTheme.darkerText,
            elevation: 5,
            backgroundColor: AppTheme.dark_grey,
            onPressed: () {
              validateAndSave();
            },
            //Implement Route To Payment Here
            label: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Total: ₹ " + widget.total.toString(),
                  style: TextStyle(color: Colors.green),
                ),
                SizedBox(
                  width: 20,
                ),
                Text("Make Payment".toUpperCase()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
