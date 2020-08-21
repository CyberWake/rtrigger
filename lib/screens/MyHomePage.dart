import 'package:flutter/material.dart';
import 'package:user/widgets/custom%20drawer.dart';
import '../Models/appbar title.dart';
import '../Models/navigation titles.dart';
import '../widgets/search.dart';
import '../screens/Home.dart';
import 'package:user/global variables.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (_) => Cart()));
            },
            color: Colors.black,
          )
        ],
      ),
      drawer: CustomDrawer(page),
      body: Home(),
    );
  }
}