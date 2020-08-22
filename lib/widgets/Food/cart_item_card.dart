import 'package:flutter/material.dart';
import 'package:user/widgets/Food/add_to_cart_button.dart';
import 'package:user/services/Food/cart.dart';

class CartItemCard extends StatefulWidget {

  CartItemCard({this.image,this.foodTitle,this.time,this.distance,this.price,this.vendorName, this.quantity, this.productID, this.onTap});

  final String image;
  final String foodTitle;
  final int price;
  final String time;
  final String vendorName;
  final String distance;
  final int quantity;
  final String productID;
  final Function onTap;

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {

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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Qty : ${widget.quantity}"),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: widget.onTap,
                        child: CartButton(title: "Remove",),
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
