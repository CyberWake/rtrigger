import 'package:flutter/material.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/gridtile.dart';

class SaloonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(context),
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
                    child: CustomGridTile(title:'Male', loc:'assets/img/male.jpg', card:Cards.male,  type:CardType.Saloon)),
                Expanded(
                    child: CustomGridTile(title:'Female', loc:'assets/img/female.jpg', card:Cards.female,type:CardType.Saloon)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: CustomGridTile(title:'Unisex', loc:'assets/img/unisex.png', card:Cards.unisex,type: CardType.Saloon)),
                Expanded(
                    child: CustomGridTile(title:'Spa', loc:'assets/img/spa.jpg', card:Cards.spa,type: CardType.Saloon)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

