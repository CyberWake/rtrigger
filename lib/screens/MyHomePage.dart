import 'package:flutter/material.dart';
import 'package:user_app/Models/appbar%20title.dart';
import 'package:user_app/Models/navigation%20titles.dart';
import 'package:user_app/screens/home.dart';
import 'package:user_app/widgets/search.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int page=0;
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
    // TODO: implement initState
    getCurrentDate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String appTitle = greeting+UserName;
    return Scaffold(
      appBar: AppBar(
        title: appbarItems[page].title!="Home"?
        Text(appbarItems[page].title)
            :Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(finalDate,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey),),
            Text(appTitle,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.black),),
          ],
        ),
        toolbarHeight: MediaQuery.of(context).size.height/11,
        actions: [
          Search(),
        ],
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, i) {
            return  ListTile(
              title: Text(navigationItems[i].title),
              onTap: (){
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Home(),
    );
  }
}