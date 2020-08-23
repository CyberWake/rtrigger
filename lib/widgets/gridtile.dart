import 'package:flutter/material.dart';
import 'package:user/widgets/custom_page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/screens/saloon_vendor_list_screen.dart';
import 'package:user/screens/sanitizer_vendor_list_screen.dart';
import 'package:user/screens/navigating_home_screen.dart';
import 'package:user/widgets/homedrawer.dart';
import 'package:user/screens/medicine_screen.dart';
import 'package:user/screens/saloon_screen.dart';
import 'package:user/screens/sanitizer_spray_screen.dart';
import 'file:///C:/Users/yasha/Desktop/a/tik_tiok_ui/rtrigger/lib/screens/food_screen.dart';

class CustomGridTile extends StatelessWidget {
  final String title;
  final String loc;
  final Cards card;
  final CardType type;
  CustomGridTile({this.title, this.loc, this.card,this.type});
  getNextScreen(BuildContext context){
    switch(type){
      case CardType.Sanitizer: return SanitizeVendorListScreen(card);break;
      case CardType.Saloon: return SaloonVendorListScreen(card);break;
      case CardType.Home: return goFromHomeTo(context);break;
    }
  }
  goFromHomeTo(BuildContext context){
    switch(card){
      case Cards.medicine : return NavigationHomeScreen(DrawerIndex.MEDICINE,MedicineScreen()/*Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => NavigationHomeScreen(DrawerIndex.MEDICINE,MedicineScreen())
          )*/
      );break;

      case Cards.food:return NavigationHomeScreen(DrawerIndex.FOOD,FoodScreen()/*Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => NavigationHomeScreen(DrawerIndex.FOOD,FoodCategoryScreen())
          )*/
      );break;

      case Cards.liqour:return NavigationHomeScreen(DrawerIndex.LIQUOR,SanitizerAndSprayScreen()/*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationHomeScreen(DrawerIndex.LIQUOR,SanitizerAndSprayScreen())
          )*/
      );break;

      case Cards.saloon:return NavigationHomeScreen(DrawerIndex.SALON,SaloonScreen()/*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationHomeScreen(DrawerIndex.SALON,SaloonScreen())
          )*/
      );break;

      case Cards.spray:return NavigationHomeScreen(DrawerIndex.SANITIZERANDSPRAY,SanitizerAndSprayScreen()/*Navigator.push(
          context,
          SlideLeftRoute(
              page: NavigationHomeScreen(DrawerIndex.SANITIZERANDSPRAY,SanitizerAndSprayScreen())
          )*/
      );break;

      case Cards.spray:return NavigationHomeScreen(DrawerIndex.VIEWALL,SanitizerAndSprayScreen()/*Navigator.push(
            context,
            SlideLeftRoute(page: NavigationHomeScreen(DrawerIndex.VIEWALL,SanitizerAndSprayScreen())
            )*/
        );break;
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
      elevation: 20,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => getNextScreen(context)));
        },
        child: Container(
          padding: EdgeInsets.all(7),
          height: screenHeight / 5,
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                loc != "null"?
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      radius:40,
                      child: ClipOval(
                          child: Image.asset(
                            loc,
                            fit: BoxFit.cover,
                          )
                      )
                  )
                    :SizedBox(height: 1,),
                Text(title,
                    style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
