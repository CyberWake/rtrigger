import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/models/food_category_list.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/food_category_card.dart';
import 'food_cart.dart';

class FoodScreen extends StatefulWidget {
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<dynamic> _listItem = FoodCategoryList().foodItems;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(context,true,"Food Category"),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              /*Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: Text(
                      "Choose Category",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FoodCart();
                      }));
                    },
                  ),
                ],
              )),*/
              Expanded(
                flex: 10,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: _listItem
                      .map((item) => FoodCategoryCard(
                            image: item["image"],
                            index: item["index"],
                            foodName: item["foodName"],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
