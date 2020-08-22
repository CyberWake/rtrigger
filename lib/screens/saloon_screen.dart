import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/saloon_gridtile.dart';

class SaloonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForSanitizerAndParlourScreen(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Saloon & Beauty Parlour',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: SaloonGridTile(
                        'Male', 'assets/img/male.jpg', SaloonCategory.male)),
                Expanded(
                    child: SaloonGridTile('Female', 'assets/img/female.jpg',
                        SaloonCategory.female)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: SaloonGridTile('Unisex', 'assets/img/unisex.png',
                        SaloonCategory.unisex)),
                Expanded(
                    child: SaloonGridTile(
                        'Spa', 'assets/img/spa.jpg', SaloonCategory.spa)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

