import 'package:flutter/material.dart';
import 'package:user/widgets/Food/food_item_card.dart';
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
  List<dynamic> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print(widget.index);
    getFoodItems();
//    print("*******************");
//    print(items);
//    print("*******************");
  }


  void getFoodItems() async{
    items = await foodFetching.getFood(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(child: Text(widget.title)),
              Expanded(
                flex: 10,
                child: ListView.builder(
                  itemBuilder: (context, index){
                    return FoodItemCard(
                      image: "assets/img/salon.png",
                      time: "10 min",
                      distance: "2 km",
                      foodTitle: items[index]["name"],
                      price: 150,
                      vendorName: "Royal Shop",
                    );
                  },
                  itemCount: items.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


