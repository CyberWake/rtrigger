import 'package:flutter/material.dart';
import 'package:user/widgets/add_to_cart_button.dart';

class CartItemCard extends StatefulWidget {
  CartItemCard(
      {this.image,
      this.foodTitle,
      this.time,
      this.distance,
      this.price,
      this.vendorName,
      this.quantity,
      this.productID,
      this.onTap,
      this.type,
      this.date,
      this.status});

  final String image;
  final String foodTitle;
  final String status;
  final int price;
  final String time;
  final String vendorName;
  final int distance;
  final int quantity;
  final String productID;
  final Function onTap;
  final String type;
  final String date;

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  void initState() {
    super.initState();
    //print(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            widget.image.isNotEmpty
                ? Expanded(
                    flex: 2,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: ClipOval(
                            child: Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                        ))),
                  )
                : SizedBox(
                    width: 10,
                  ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.foodTitle.toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Rs. ${widget.price} | ${widget.distance} KM",
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  widget.type == "Cart"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(widget.time),
                            Text("(${widget.vendorName})"),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("ID: " + widget.time),
                            Text("OTP: ${widget.vendorName}"),
                          ],
                        ),
                  widget.type != "Cart"
                      ? Text(
                          "Date: ${widget.date}",
                          style: TextStyle(fontSize: 16),
                        )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Qty : ${widget.quantity}",
                        style: TextStyle(fontSize: 16),
                      ),
                      widget.type == "Cart"
                          ? FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: widget.onTap,
                              child: CartButton(
                                title: "Remove",
                              ),
                            )
                          : Text(
                              widget.status,
                              style: TextStyle(fontSize: 16),
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
