import 'package:flutter/material.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/gridtile.dart';

class SanitizerAndSprayScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForSanitizerAndParlourScreen(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                    child: CustomGridTile(
                        title:'Sanitize', loc:'assets/img/sanitize.png', card:Cards.sanitize,
                        type:CardType.Sanitizer)
                ),
                Expanded(
                    child: CustomGridTile(
                        title:'Mosquito', loc:'assets/img/mosquito.jpg',card: Cards.mosquito,
                        type:CardType.Sanitizer)
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: CustomGridTile(
                        title:'Cockroach', loc:'assets/img/cockroch.jpg', card:Cards.cockroach,
                        type:CardType.Sanitizer)
                ),
                Expanded(child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

