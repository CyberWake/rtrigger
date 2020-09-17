import 'package:flutter/material.dart';
import 'package:user/screens/food_items.dart';
import 'package:user/screens/vendor_screen.dart';

class FoodCategoryCard extends StatelessWidget {
  FoodCategoryCard({this.index, this.foodName, this.image});

  final String image;
  final String foodName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 14) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return VendorScreen();
          }));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FoodItems(
              title: foodName,
              index: index,
            );
          }));
        }
      },
      child: Card(
        elevation: 10,
        child: index == 14
            ? Center(
                child: Text(foodName,
                    style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                    )))
            : Container(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4.5,
                        height: MediaQuery.of(context).size.width / 4.5,
                        margin: EdgeInsets.only(bottom: 1),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                          index == 13 ? 'assets/img/oo.png' : image,
                        ))),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(foodName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
