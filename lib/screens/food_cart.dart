import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user/auth/auth.dart';
import 'package:user/models/profile.dart';
import 'package:user/widgets/cart_item_card.dart';
import 'package:user/models/apptheme.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user/services/Food/cart.dart';

class FoodCart extends StatefulWidget {
  final bool isAppbar;
  FoodCart(this.isAppbar);
  @override
  _FoodCartState createState() => _FoodCartState();
}

class _FoodCartState extends State<FoodCart> {
  Auth auth = Auth();
  UserProfile profile;
  Razorpay _razorpay;
  final _userID = FirebaseAuth.instance.currentUser.uid;
  Cart cart = Cart();
  var cartItems = [];
  int total = 0;
  bool isLoading = true;

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
    return await showDialog(
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
      setState(() {
        isLoading = false;
      });
    });
    getCartData();
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> makePayment() async {
    var options = {
      'key': 'rzp_test_Fs6iRWL4ppk5ng',
      'amount': total * 100, //in paise so * 100
      'name': 'Rtiggers',
      'description':
          'Order Payment for id - ' + profile.username + total.toString(),
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

  void calculateTotal() {
    total = 0;
    print("calculating Total");

    for (int i = 0; i < cartItems.length; i++) {
      setState(() {
        total = total + cartItems[i]["price"] * cartItems[i]["quantity"];
      });
    }
  }

  void getCartData() async {
    var temp = await cart.getCartItems(_userID);
    print(temp);
    setState(() {
      cartItems = temp;
      calculateTotal();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppbar?
      AppBar(backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Your Cart",
          style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      )
          :AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 8),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : total==0?Container(
          padding: EdgeInsets.all(15),
          child: Text("Nice to have you here..\nFirst add something in cart",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width/15),),
        ):
        SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 9,
                        child: Container(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return CartItemCard(
                                vendorName: cartItems[index]["vendor"],
                                price: cartItems[index]["price"],
                                foodTitle: cartItems[index]["name"],
                                distance: "2 km",
                                time: "10 min",
                                image: cartItems[index]["image"],
                                quantity: cartItems[index]["quantity"],
                                productID: cartItems[index]["productID"],
                                onTap: () async {
                                  Cart cart = Cart();
                                  var deleteResult = await cart.deleteFromCart(
                                      userID: _userID,
                                      productID: cartItems[index]["productID"]);
                                  if (deleteResult == true) {
                                    getCartData();
                                    //calculateTotal();
                                  }
                                },
                              );
                            },
                            itemCount: cartItems.length,
                          ),
                        )),
                  ],
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
              makePayment();
            },
            //Implement Route To Payment Here
            label: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Total: ₹ $total ".toUpperCase(),
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
