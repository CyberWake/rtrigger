import 'package:flutter/material.dart';
import 'package:user/widgets/food_item_card.dart';
import 'package:user/models/apptheme.dart';
import 'package:user/widgets/food_item_card.dart';
import 'package:user/services/Food/food_fetching.dart';

class FoodItems extends StatefulWidget {
  FoodItems({this.title, this.index});

  final String title;
  final int index;

  @override
  _FoodItemsState createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  FoodFetching foodFetching = FoodFetching();
  List<dynamic> items = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getFoodItems();
  }

  void getFoodItems() async {
    var fetchedData = await foodFetching.getFood(widget.index);
    setState(() {
      items = fetchedData;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.dark_grey,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: isLoaded
            ? items.length == 0
                ? Center(
                    child: Text(
                      'No items available now, Please check after sometime.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25),
                    ),
                  )
                : Container(
                    child: Expanded(
                      flex: 10,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return FoodItemCard(
                            image: items[index]["img"],
                            time: "10 min",
                            distance: "2 km",
                            foodTitle: items[index]["name"],
                            price: int.parse(items[index]["price"]),
                            vendorName: "Royal Shop",
                          );
                        },
                        itemCount: items.length,
                      ),
                    ),
                  )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
