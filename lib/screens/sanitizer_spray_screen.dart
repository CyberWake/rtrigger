import 'package:flutter/material.dart';
import 'package:user/Models/sanitizer_screen_categories.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left:15.0,right: 15,top: 60),
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
              Expanded(
                  child: Opacity(
                      opacity: 0,
                      child: SanitizeGridTile(
                          'Mosquito', 'assets/img/sanitize.png', null))),
            ],
          ),
        ],
      ),
    );
    /*Scaffold(
      //appBar: AppBarForSanitizerAndParlourScreen(context),
      body:
    );*/
  }
}
