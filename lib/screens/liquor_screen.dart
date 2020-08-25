import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/models/apptheme.dart';
import 'package:user/models/liquor_category_list.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/food_category_card.dart';

import 'food_cart.dart';

class LiquorScreen extends StatelessWidget {
  List<dynamic> _listItem = LiquorCategoryList().liquorItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(context, true, "Liqour Category"),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 16),
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  //flex: 10,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GridView.builder(itemCount: 4,
                          
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (_, index) {
                              //if (index < 4)
                                return FoodCategoryCard(
                                  image: _listItem[index]["image"],
                                  index: _listItem[index]["index"] + 15,
                                  foodName: _listItem[index]["foodName"],
                                );
                            }),
                      ),
                      Expanded(flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              child: FoodCategoryCard(
                                image: _listItem[4]["image"],
                                index: _listItem[4]["index"] + 15,
                                foodName: _listItem[4]["foodName"],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
