import 'package:flutter/material.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
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
      appBar: UniversalAppBar(context, true, widget.title),
      body: SafeArea(
        child: isLoaded
            ? Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return FoodItemCard(
                      image: items[index]["img"],
                      time: items[index]["prep"].toString(),
                      distance: (items[index]['distance'] as double)
                              .toInt()
                              .toString() +
                          ' km',
                      foodTitle: items[index]["name"],
                      price: int.parse(items[index]["price"]),
                      vendorName: items[index]['shop'],
                      vendorId: items[index]['vendorId'],
                    );
                  },
                  itemCount: items.length,
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
