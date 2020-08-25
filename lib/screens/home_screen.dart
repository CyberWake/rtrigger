import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/widgets/gridtile.dart';
import 'package:user/models/categories_enum.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  List imageArray = List();
  @override
  void initState() {
    Firebase.initializeApp();
    tabController = TabController(length: 4, vsync: this);
    getImages();
    super.initState();
  }

  Future<void> getImages() async {
    final User user = FirebaseAuth.instance.currentUser;
    var auth = FirebaseFirestore.instance;
    await auth
        .collection('displayImages')
        .doc('VRxueMwcdcW4VmDR721r')
        .get()
        .then((value) {
      setState(() {
        imageArray = value.data()['home'];
      });
      print(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    getImages();
    print(imageArray);
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
                      type: CardType.Home)),
              Expanded(
                  child: CustomGridTile(
                      title: 'Food',
                      loc: 'assets/img/food.png',
                      card: Cards.food,
                      type: CardType.Home)),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: CustomGridTile(
                      title: 'Liqour',
                      loc: 'assets/img/liquor.png',
                      card: Cards.liqour,
                      type: CardType.Home)),
              Expanded(
                  child: CustomGridTile(
                      title: 'Saloon and Beauty Parlour',
                      loc: 'assets/img/salon.png',
                      card: Cards.saloon,
                      type: CardType.Home)),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: CustomGridTile(
                    title: 'Santizer and Spray',
                    loc: 'assets/img/sanitize.png',
                    card: Cards.spray,
                    type: CardType.Home),
              ),
              Expanded(child: Container()),
            ],
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              //pauseAutoPlayOnTouch: Duration(seconds: 10),
              aspectRatio: 2.0,
            ),
            items: imageArray.map((url) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.grey[300],
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              });
            }).toList(),
          ),
        ],
      ),
    );
  }
}
