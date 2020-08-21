import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/tiles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController tabController;
  @override
  void initState() {
    tabController=TabController(length: 4,vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: GridView.builder(
        itemCount: 6,
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,),
          itemBuilder: (BuildContext context,int i)=>Tiles(i)
      )
    );
  }
}
