import 'package:flutter/material.dart';
import 'package:user/models/liquor_category_list.dart';
import 'package:user/widgets/food_category_card.dart';

import 'food_cart.dart';


class LiquorCategory extends StatelessWidget {

  List<dynamic> _listItem = LiquorCategoryList().liquorItems;

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
                          Text("Liquor"),
                          SizedBox(width: MediaQuery.of(context).size.width*0.7),
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context){
                                    return FoodCart();
                                  }
                              ));
                            },
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
                          index: item["index"]+15,
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
