import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/cart_item_card.dart';
import 'package:user/models/apptheme.dart';

class OrderScreen extends StatefulWidget {
  final bool isAppbar;

  OrderScreen(this.isAppbar);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var cartItems = [];
  int total = 0;
  bool isLoading = true;

  @override
  void initState() {
    getOrderData().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> getOrderData() async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    var userorders = await FirebaseFirestore.instance
        .collection("userOrders")
        .doc(uid)
        .get();
    List<dynamic> userOrders =
        userorders.data()["orders"] != null ? userorders.data()["orders"] : [];
    cartItems = userOrders;
    print(cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppbar
          ? AppBar(
              backgroundColor: Colors.blueGrey,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "Your Orders",
                style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          : AppBar(
              toolbarHeight: 50,
              centerTitle: true,
              title: Text("Orders"),
              backgroundColor: AppTheme.grey,
            ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cartItems.length == 0
              ? Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Nice to have you here..\nGive us the chance to serve you!!",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 15),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 9,
                        child: Container(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return CartItemCard(
                                vendorName: cartItems[index]["otp2"].toString(),
                                price: cartItems[index]["price"],
                                foodTitle: cartItems[index]["item"],
                                distance: cartItems[index]["distance"],
                                time: cartItems[index]["id"],
                                image: cartItems[index]["image"],
                                quantity: cartItems[index]["quantity"],
                                productID: cartItems[index]["productID"],
                                type: "Orders",
                                date: cartItems[index]["date"],
                                status: cartItems[index]["status"],
                                onTap: () async {
                                  /*Cart cart = Cart();
                            var deleteResult = await cart.deleteFromCart(
                                userID: _userID,
                                productID: cartItems[index]["productID"]);
                            if (deleteResult == true) {
                              getCartData();
                              //calculateTotal();
                            }*/
                                },
                              );
                            },
                            itemCount: cartItems.length,
                          ),
                        )),
                  ],
                ),
    );
  }
}
