import 'package:flutter/material.dart';

import '../colors.dart';

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
      color:Colors.red,
    );
  }
}
