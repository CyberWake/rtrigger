import 'package:flutter/material.dart';
import 'package:user/sanitizer/utilities/categories.dart';
import 'package:user/sanitizer/widgets/appbar_for_sanitizer_and_parlour_screen.dart';
import 'package:user/sanitizer/widgets/sanitize_gridtile.dart';

class SanitizerAndSprayScreen extends StatefulWidget {
  @override
  _SanitizerAndSprayScreenState createState() => _SanitizerAndSprayScreenState();
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
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const Text(
              'Sanitizer and Spray',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: SanitizeGridTile(
                        'Sanitize', 'assets/img/sanitize.png', Category.sanitize)),
                Expanded(
                    child: SanitizeGridTile(
                        'Mosquito', 'assets/img/mosquito.jpg', Category.mosquito)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: SanitizeGridTile('Cockroach', 'assets/img/cockroch.jpg',
                        Category.cockroach)),
                Expanded(
                    child: Opacity(
                        opacity: 0,
                        child: SanitizeGridTile(
                            'Mosquito', 'assets/img/sanitize.png', null))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}