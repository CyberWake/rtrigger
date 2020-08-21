import 'package:flutter/material.dart';
import 'package:user/screens/homescreen.dart';
import 'package:user/widgets/homedrawer.dart';
import 'package:user/widgets/search.dart';

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
  String UserName = " Aditya";
  String greeting = "Hello,";
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
    getCurrentDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String appTitle = greeting+UserName;
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          appBar: AppBar(
            toolbarHeight: 65,
            title: _getTitle(drawerIndex),
            backgroundColor: AppTheme.grey,
          ),
          body: DrawerUserController(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(finalDate,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey),),
                                    Text("Hello, Aditya",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.black),),
                                  ],
                                ),
                                Search(),
                                IconButton(
                                  onPressed: (){
                                    print("cart button pressed");
                                  },
                                    icon:Icon(Icons.add_shopping_cart)
                                )
                              ]
                            );
                            break;
      case DrawerIndex.FAVOURITE: return Text("Favourites");break;
      case DrawerIndex.ORDERS: return Text("Orders");break;
      case DrawerIndex.MYCART: return Text("My Cart");break;
      case DrawerIndex.PROFILE: return Text("Profile");break;
      case DrawerIndex.NOTIFICATIONS: return Text("Notifications");break;
      case DrawerIndex.CONTACTUS: return Text("Contatct Us");break;
    }
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = Home();
        });
      } else if (drawerIndex == DrawerIndex.FAVOURITE) {
        setState(() {
          screenView = Home();
        });
      } else if (drawerIndex == DrawerIndex.ORDERS) {
        setState(() {
          screenView = Home();
        });
      } else if (drawerIndex == DrawerIndex.MYCART) {
        setState(() {
          screenView = Home();
        });
      } else if (drawerIndex == DrawerIndex.PROFILE) {
        setState(() {
          screenView = Home();
        });
      } else if (drawerIndex == DrawerIndex.NOTIFICATIONS) {
        setState(() {
          screenView = Home();
        });
      } else if (drawerIndex == DrawerIndex.CONTACTUS) {
        setState(() {
          screenView = Home();
        });
      }
      else {
        //do in your way......
      }
    }
  }
}