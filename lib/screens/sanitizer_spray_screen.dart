import 'package:flutter/material.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/sanitize_gridtile.dart';

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
                    child: SanitizeGridTile('Sanitize',
                        'assets/img/sanitize.png', Category.sanitize)),
                Expanded(
                    child: SanitizeGridTile('Mosquito',
                        'assets/img/mosquito.jpg', Category.mosquito)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: SanitizeGridTile('Cockroach',
                        'assets/img/cockroch.jpg', Category.cockroach)),
                Expanded(child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
    /*Scaffold(
      //appBar: AppBarForSanitizerAndParlourScreen(context),
      body:
    );*/
  }
}
