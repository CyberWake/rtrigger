import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/Food/food_category_card.dart';
import 'package:user/models/food_category_list.dart';

class FoodCategory extends StatefulWidget {
  @override
  _FoodCategoryState createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {

  List<dynamic> _listItem = FoodCategoryList().foodItems;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(child: Text("Choose category")),
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Food"),
                          SizedBox(width: MediaQuery.of(context).size.width*0.7),
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: _listItem.map((item) => FoodCategoryCard(
                          image: item["image"],
                          index: item["index"],
                          foodName: item["foodName"],
                        )).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Column(
//children: [
//Text("Choose Category"),
//ListView(
//children: [
//Row(
//children: [
//Text("Food"),
//IconButton(
//icon: Icon(Icons.add_shopping_cart),
//),
//],
//),
//],
//),
//],
//),