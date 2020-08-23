import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user/models/apptheme.dart';
import 'package:user/widgets/Food/cart_item_card.dart';
import 'package:user/services/Food/cart.dart';

class FoodCart extends StatefulWidget {
  @override
  _FoodCartState createState() => _FoodCartState();
}

class _FoodCartState extends State<FoodCart> {
  var _firestore = FirebaseFirestore.instance;
  Cart cart = Cart();
  var cartItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartData();
  }

  void getCartData() async {
    var temp = await cart.getCartItems("Harsh");
    setState(() {
      cartItems = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: AppTheme.dark_grey,
      ),
      body: SafeArea(
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
                        image: "assets/img/salon.png",
                        quantity: cartItems[index]["quantity"],
                        productID: cartItems[index]["productID"],
                        onTap: () async {
                          Cart cart = Cart();
                          var deleteResult = await cart.deleteFromCart(
                              userID: "Harsh",
                              productID: cartItems[index]["productID"]);
                          if (deleteResult == true) {
                            getCartData();
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
    );
  }
}
