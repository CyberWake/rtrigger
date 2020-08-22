import 'package:flutter/material.dart';
import 'package:user/services/Food/cart.dart';
import 'package:user/widgets/Food/add_to_cart_button.dart';
import 'package:uuid/uuid.dart';

class FoodItemCard extends StatefulWidget {

  FoodItemCard({this.image,this.foodTitle,this.time,this.distance,this.price,this.vendorName});

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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image(
                image: AssetImage(widget.image),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Text(widget.foodTitle),
                  Text("Rs. ${widget.price}"),
                  Text(widget.time),
                  Text("(${widget.vendorName} | ${widget.distance})"),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: (){
                          if(quantity>0){
                            setState(() {
                              quantity -= 1;
                            });
                          }
                        },
                      ),
                      Text("$quantity"),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: (){
                          if(quantity<10){
                            setState(() {
                              quantity += 1;
                            });
                          }
                        },
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: (){
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
                          cart.addToCart(userID: "Harsh", item: [cartItem]);
                        },
                        child: CartButton(title: "Add to Cart",),
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
