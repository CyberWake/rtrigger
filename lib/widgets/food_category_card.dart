import 'package:flutter/material.dart';
import 'file:///C:/Users/yasha/Desktop/a/tik_tiok_ui/rtrigger/lib/screens/food_items.dart';

class FoodCategoryCard extends StatelessWidget {

  FoodCategoryCard({this.index,this.foodName,this.image});

  final String image;
  final String foodName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context){
            return FoodItems(title: foodName,index: index,);
          }
        ));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 5,
              child: Image(
                image: AssetImage(image),
              ),
            ),
            Expanded(flex:2,child: Text(foodName, textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }
}
