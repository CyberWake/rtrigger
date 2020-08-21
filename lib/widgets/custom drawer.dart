import 'package:flutter/material.dart';
import 'package:user/Models/navigation%20titles.dart';

import '../global variables.dart';

class CustomDrawer extends StatelessWidget {
  final int currentPage;
  CustomDrawer(this.currentPage);

  Widget _tile(int num,BuildContext context){
    return ListTile(
      title: Text(navigationItems[num].title,
        style: TextStyle(
            fontSize:page==num?22:20,
            color:page==num?Colors.black:Colors.black45,
            fontWeight: page==num?FontWeight.bold:FontWeight.normal
        ),
      ),
      trailing: Icon(navigationItems[num].icon),
      onTap: (){
        page=num;
        Navigator.pop(context);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:  AssetImage("assets/img/food.png")
                  )
              ),
              child: Stack(children: <Widget>[
                Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text("Welcome to Flutter",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500))),
              ]
              )
          ),
          _tile(0,context),
          _tile(1,context),
          _tile(2,context),
          _tile(3,context),
          _tile(4,context),
          _tile(5,context),
          _tile(6,context),
          SizedBox(height: MediaQuery.of(context).size.height/6,),
          _tile(7,context),
        ],
      ),
    );
  }
}
