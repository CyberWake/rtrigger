import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user/widgets/cart_item_card.dart';
import 'package:user/models/apptheme.dart';
import 'package:user/widgets/cart_item_card.dart';
import 'package:user/services/Food/cart.dart';

class FoodCart extends StatefulWidget {
  @override
  _FoodCartState createState() => _FoodCartState();
}

class _FoodCartState extends State<FoodCart> {
  var _firestore = FirebaseFirestore.instance;
  Cart cart = Cart();
  var cartItems = [];
  int total = 0;

  @override
  void initState() {
    getCartData();
    super.initState();
  }

  void getCartData() async {
    var temp = await cart.getCartItems("Harsh");
    setState(() {
      cartItems = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < cartItems.length; i++) {
      setState(() {
        total = total + cartItems[i]["price"] * cartItems[i]["quantity"];
      });
    }  
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
        bottomNavigationBar: BottomAppBar(
          color: AppTheme.dark_grey,
          elevation: 5,
          child: Container(
            child: FloatingActionButton.extended(
              splashColor: AppTheme.darkerText,
              elevation: 5,
              backgroundColor: AppTheme.dark_grey,
              onPressed: () {}, //Implement Route To Payment Here
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
        ));
  }
}
