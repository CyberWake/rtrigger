import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/gridtile.dart';
import 'package:user/models/categories_enum.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    Firebase.initializeApp();
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 60, left: 5, right: 5),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Row(
            children: [
              Expanded(
                  child: CustomGridTile(
                      title: 'Medicine',
                      loc: 'assets/img/medicine.png',
                      card: Cards.medicine,
                      type: CardType.Medicine)),
              Expanded(
                  child: CustomGridTile(
                      title: 'Food',
                      loc: 'assets/img/food.png',
                      card: Cards.food,
                      type: CardType.Food)),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: CustomGridTile(
                      title: 'Liqour',
                      loc: 'assets/img/liquor.png',
                      card: Cards.liqour,
                      type: CardType.Home
                  )),
              Expanded(
                  child: CustomGridTile(
                      title: 'Saloon and Beauty Parlour',
                      loc: 'assets/img/salon.png',
                      card: Cards.saloon,
                      type: CardType.Home)),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: CustomGridTile(
                      title: 'Santizer and Spray',
                      loc: 'assets/img/sanitize.png',
                      card: Cards.spray,
                      type: CardType.Home)),
              Expanded(child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
