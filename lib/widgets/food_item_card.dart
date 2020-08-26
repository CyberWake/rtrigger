import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user/services/Food/cart.dart';
import 'package:user/widgets/add_to_cart_button.dart';
import 'package:uuid/uuid.dart';

class FoodItemCard extends StatefulWidget {
  FoodItemCard(
      {this.image,
      this.foodTitle,
      this.time,
      this.distance,
      this.price,
      this.vendorName});

  final String image;
  final String foodTitle;
  final int price;
  final String time;
  final String vendorName;
  final String distance;

  @override
  _FoodItemCardState createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  int quantity = 1;
  var productID = Uuid().v1();
  Cart cart = Cart();
  bool isLoaded = true;
  final _userID = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: ClipOval(
                      child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  ))),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(widget.foodTitle.toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.bold,
                          fontSize: 20), textAlign: TextAlign.center,),
                  Divider(),
                  Text(
                    "₹ ${widget.price} | ${widget.distance}",
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  Divider(),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(widget.time),
                        SizedBox(width: 10,),
                        Text("(${widget.vendorName})"),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 0) {
                            setState(() {
                              quantity -= 1;
                            });
                          }
                        },
                      ),
                      Text("$quantity"),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (quantity < 10) {
                            setState(() {
                              quantity += 1;
                            });
                          }
                        },
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          var cartItem = {
                            "image": widget.image,
                            "name": widget.foodTitle,
                            "price": widget.price,
                            "quantity": quantity,
                            "vendor": widget.vendorName,
                            "time": widget.time,
                            "productID": productID,
                            "distance": widget.distance,
                          };
                          setState(() {
                            isLoaded = false;
                          });
                          cart.addToCart(
                              userID: _userID, item: [cartItem]).then((value) {
                            setState(() {
                              isLoaded = true;
                            });
                            if (value) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Item added to cart"),
                              ));
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Unable to add item, Please try again later"),
                              ));
                            }
                          });
                        },
                        child: isLoaded
                            ? CartButton(
                                title: "Add to Cart",
                              )
                            : Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
