import 'package:flutter/material.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_for_sanitizer_and_parlour_screen.dart';
import 'package:user/widgets/sanitize_gridtile.dart';

class SanitizerAndSprayScreen extends StatefulWidget {
  @override
  _SanitizerAndSprayScreenState createState() =>
      _SanitizerAndSprayScreenState();
}

class _SanitizerAndSprayScreenState extends State<SanitizerAndSprayScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                        'assets/img/sanitize.png', SanitizeCategory.sanitize)),
                Expanded(
                    child: SanitizeGridTile('Mosquito',
                        'assets/img/mosquito.jpg', SanitizeCategory.mosquito)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: SanitizeGridTile('Cockroach',
                        'assets/img/cockroch.jpg', SanitizeCategory.cockroach)),
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
