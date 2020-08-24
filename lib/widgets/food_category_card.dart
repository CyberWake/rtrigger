import 'package:flutter/material.dart';
import 'package:user/screens/food_items.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodCategoryCard extends StatelessWidget {
  FoodCategoryCard({this.index, this.foodName, this.image});

  final String image;
  final String foodName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FoodItems(
            title: foodName,
            index: index,
          );
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 5,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 33,
                    child: ClipOval(
                        child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ))),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  foodName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}