import 'package:flutter/material.dart';
import 'package:user/auth/auth.dart';
import 'package:user/models/profile.dart';
import 'package:user/screens/drawer_contact_screen.dart';
import 'package:user/screens/drawer_profile_screen.dart';
import 'package:user/screens/home_screen.dart';
import 'package:user/widgets/homedrawer.dart';
import '../Models/apptheme.dart';
import '../widgets/customdrawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  final DrawerIndex index;
  final Widget viewScreen;
  NavigationHomeScreen(this.index,this.viewScreen);
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  String finalDate = '';
  Auth auth = Auth();
  UserProfile profile;
  String UserName = " User";
  getCurrentDate(){
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    finalDate = formattedDate.toString() ;
  }
  @override
  void initState() {
    auth.getProfile().whenComplete(() {
      profile = auth.profile;
      UserName = profile.username;
    });
    drawerIndex = widget.index;
    screenView = widget.viewScreen;
      getCurrentDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                    Text("Hello "+UserName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.black),),
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
      case DrawerIndex.FAVOURITE: return Text("Favourites");break;
      case DrawerIndex.ORDERS: return Text("Orders");break;
      case DrawerIndex.MYCART: return Text("My Cart");break;
      case DrawerIndex.PROFILE: return Text("Profile");break;
      case DrawerIndex.NOTIFICATIONS: return Text("Notifications");break;
      case DrawerIndex.CONTACTUS: return Text("Contatct Us");break;
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
      } else if (drawerIndex == DrawerIndex.FAVOURITE) {
        setState(() {
          screenView = Home();
          drawerIndex = DrawerIndex.FAVOURITE;
        });
      } else if (drawerIndex == DrawerIndex.ORDERS) {
        setState(() {
          screenView = Home();
          drawerIndex = DrawerIndex.ORDERS;
        });
      } else if (drawerIndex == DrawerIndex.MYCART) {
        setState(() {
          screenView = Home();
          drawerIndex = DrawerIndex.MYCART;
        });
      } else if (drawerIndex == DrawerIndex.PROFILE) {
        setState(() {
          screenView = Profile();
          drawerIndex = DrawerIndex.PROFILE;
        });
      } else if (drawerIndex == DrawerIndex.NOTIFICATIONS) {
        setState(() {
          screenView = Home();
          drawerIndex = DrawerIndex.NOTIFICATIONS;
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