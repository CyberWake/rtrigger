import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/Models/categorytitle.dart';
import 'package:user/screens/medicine_screen.dart';
import 'package:user/screens/navigating_home_screen.dart';
import 'package:user/screens/saloon_screen.dart';
import 'package:user/screens/sanitizer_spray_screen.dart';
import 'package:user/widgets/custom_page_transition.dart';
import '../screens/food_screen.dart';
import 'homedrawer.dart';

class Tiles extends StatelessWidget {
  final int index;
  Tiles(this.index);

  MainAxisAlignment mainAixsAlignment(bool isMedicine,String  title,int index){
    if (isMedicine && index!=5){
      return MainAxisAlignment.start;
    }
    else if(!isMedicine && index!=5){
      return MainAxisAlignment.end;
    }
    else{
      return MainAxisAlignment.center;
    }
  }
  _getNextScreen(int page,BuildContext context){
    switch(page){
      case 0:Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => NavigationHomeScreen(DrawerIndex.MEDICINE,MedicineScreen())
              )
            );break;

      case 1:Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => NavigationHomeScreen(DrawerIndex.FOOD,FoodCategory())
              )
            );break;

      case 2:Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationHomeScreen(DrawerIndex.LIQUOR,SanitizerAndSprayScreen())
              )
            );break;

      case 3:Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationHomeScreen(DrawerIndex.SALON,SaloonScreen())
              )
            );break;

      case 4:Navigator.push(
              context,
              SlideLeftRoute(
                page: NavigationHomeScreen(DrawerIndex.SANITIZERANDSPRAY,SanitizerAndSprayScreen())
              )
            );break;

      case 5:
        print('hi');
        Navigator.push(
              context,
              SlideLeftRoute(page: NavigationHomeScreen(DrawerIndex.VIEWALL,SanitizerAndSprayScreen()))
            );break;
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isMedicine = categoryItems[index].title=="Medicine"?true:false;
    return Card(
      elevation: 40,
      color: Colors.white,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            _getNextScreen(index,context);
          },
          child: Container(
            height: MediaQuery.of(context).size.width/2-10,
            width: MediaQuery.of(context).size.width/2-10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: mainAixsAlignment(isMedicine,categoryItems[index].title,index),
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                index!=5?Image.asset(categoryItems[index].imgpath,height:isMedicine?170:130,width: isMedicine?170:130,):SizedBox(height:1,width:10),
                Text(isMedicine?categoryItems[index].title:"\n"+categoryItems[index].title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w800,color: Colors.black45)),
                isMedicine?SizedBox(height: 1,):SizedBox(height: 8,)
              ],
            )
          ),
        ),
    );
  }
}
