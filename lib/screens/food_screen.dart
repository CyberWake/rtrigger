import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/models/food_category_list.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/food_category_card.dart';
import 'food_cart.dart';

class FoodScreen extends StatefulWidget {
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<dynamic> _listItem = FoodCategoryList().foodItems;
  List imageArray = List();

  @override
  void initState() {
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
            imageArray = value.data()['foodMenu'];
          });
      
      print(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    getImages();
    return Scaffold(
      appBar: UniversalAppBar(context, true, "Food Category"),
      body: Container(
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: GridView.count(
                crossAxisCount: 3,
                children: _listItem
                    .map((item) => FoodCategoryCard(
                          image: item["image"],
                          index: item["index"],
                          foodName: item["foodName"],
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              flex: 1,
              child: CarouselSlider(
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
                        child: CachedNetworkImage(
                          imageUrl: url,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                            fit: BoxFit.cover
                        )
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
