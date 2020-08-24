//import 'package:flutter/material.dart';
//import 'package:user/models/food_category_list.dart';
//import '../widgets/appbar_subcategory_screens.dart';
//
//class FoodScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    FoodCategoryList foodCatClass = FoodCategoryList();
//    return Scaffold(
//      appBar: AppBarForSanitizerAndParlourScreen(context),
//      body: Padding(
//          padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
//          child: Column(
//            children: [
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(
//                  'Food Categories',
//                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                ),
//              ),
//              Expanded(
//                child: GridView.builder(
//                    itemCount: foodCatClass.foodItems.length,
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisCount: 3),
//                    itemBuilder: (BuildContext context, int index) {
//                      return CardTile(
//                          foodCatClass.foodItems[index]["foodName"],
//                          foodCatClass.foodItems[index]["image"],
//                          foodCatClass.foodItems[index]["index"],
//                          null);
//                    }),
//              ),
//            ],
//          )),
//    );
//  }
//}
//
//class CardTile extends StatelessWidget {
//  final String loc;
//  final String title;
//  final int saloonCategory;
//  final Function function;
//  CardTile(this.title, this.loc, this.saloonCategory, this.function);
//
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      elevation: 20,
//      child: InkWell(
//        onTap:
//            function /* () {
//          /*  Navigator.of(context).push(MaterialPageRoute(
//              builder: (_) => SaloonVendorListScreen(saloonCategory))); */
//        } */
//        ,
//        child: Container(
//          padding: EdgeInsets.all(7),
//          height: MediaQuery.of(context).size.height / 5,
//          child: FittedBox(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                if (loc != null)
//                  CircleAvatar(
//                      backgroundColor: Colors.white,
//                      radius:
//                          title == 'Medicine' || title == 'Liquor' ? 40 : 33,
//                      child: ClipOval(
//                          child: Image.asset(
//                        loc,
//                        fit: BoxFit.cover,
//                      ))),
//                Text(title,
//                    style: TextStyle(
//                        fontFamily: 'RobotoCondensed',
//                        fontWeight: FontWeight.bold,
//                        fontSize: 13)),
//              ],
//            ),
//          ),
//          decoration: BoxDecoration(
//              color: Colors.white, borderRadius: BorderRadius.circular(15)),
//        ),
//      ),
//    );
//  }
//}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user/models/food_category_list.dart';
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
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: Text(
                      "Choose Category",
                      style: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
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
              )),
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
