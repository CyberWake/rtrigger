import 'package:flutter/material.dart';
import 'package:user/auth/auth.dart';
import 'package:user/models/profile.dart';
import 'package:user/screens/drawer_contact_screen.dart';
import 'package:user/screens/drawer_order_screen.dart';
import 'package:user/screens/drawer_profile_screen.dart';
import 'package:user/screens/food_cart.dart';
import 'package:user/screens/home_screen.dart';
import 'package:user/widgets/homedrawer.dart';
import '../Models/apptheme.dart';
import '../widgets/customdrawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  String finalDate = '';
  Auth auth = Auth();
  UserProfile profile;
  String userName = "";

  getCurrentDate(){
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    finalDate = formattedDate.toString() ;
  }

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = Home();

    super.initState();
  }
  getUserName ()async{
    await auth.getProfile().whenComplete(() {
      profile = auth.profile;
      userName = profile.username;
      print(userName);
    });
  }
  @override
  Widget build(BuildContext context) {
    getCurrentDate();
    getUserName();
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            appBar: AppBar(
              toolbarHeight: 50,
              title: _getTitle(drawerIndex),
              backgroundColor: AppTheme.grey,
            ),
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  _getTitle(DrawerIndex index){
    switch(index){
      case DrawerIndex.HOME: return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(finalDate,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.grey),),
                                    Text("Hello "+userName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black),),
                                  ],
                                ),
                                //Search(),
                                /*IconButton(
                                  onPressed: (){
                                    print("cart button pressed");
                                  },
                                    icon:Icon(Icons.add_shopping_cart)
                                )*/
                              ]
                            );
                            break;
      case DrawerIndex.ORDERS: return Padding(
          padding:EdgeInsets.only(left: MediaQuery.of(context).size.width/12),
          child: Text("Orders")
      );break;
      case DrawerIndex.MYCART: return Padding(
          padding:EdgeInsets.only(left: MediaQuery.of(context).size.width/12),
          child: Text("My Cart")
      );break;
      case DrawerIndex.PROFILE: return Padding(
          padding:EdgeInsets.only(left: MediaQuery.of(context).size.width/12),
          child: Text("Profile")
      );break;
      case DrawerIndex.CONTACTUS: return Padding(
          padding:EdgeInsets.only(left: MediaQuery.of(context).size.width/12),
          child: Text("Contact Us")
      );break;
      case DrawerIndex.MEDICINE: return Text("Medicine");break;
      case DrawerIndex.FOOD: return Text("Food");break;
      case DrawerIndex.LIQUOR: return Text("Liquor");break;
      case DrawerIndex.SALON: return Text("Salon and Beauty Parlour");break;
      case DrawerIndex.SANITIZERANDSPRAY: return Text("Sanitizer and Spray");break;
      case DrawerIndex.VIEWALL: return Text("View All");break;
    }
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = Home();
          drawerIndex = DrawerIndex.HOME;
        });
      } else if (drawerIndex == DrawerIndex.ORDERS) {
        setState(() {
          screenView = OrderScreen(false);
          drawerIndex = DrawerIndex.ORDERS;
        });
      } else if (drawerIndex == DrawerIndex.MYCART) {
        setState(() {
          screenView = FoodCart(false);
          drawerIndex = DrawerIndex.MYCART;
        });
      } else if (drawerIndex == DrawerIndex.PROFILE) {
        setState(() {
          screenView = Profile(isAppBar: false);
          drawerIndex = DrawerIndex.PROFILE;
        });
      } else if (drawerIndex == DrawerIndex.CONTACTUS) {
        setState(() {
          screenView = Contact();
          drawerIndex = DrawerIndex.CONTACTUS;
        });
      }
      else {
        //do in your way......
      }
    }
  }
}