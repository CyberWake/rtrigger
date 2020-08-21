import 'package:flutter/material.dart';
import 'file:///C:/Users/lenovo/Desktop/AndroidStudioProjects/rtrigger/lib/widgets/appbar_for_sanitizer_and_parlour_screen.dart';
import 'file:///C:/Users/lenovo/Desktop/AndroidStudioProjects/rtrigger/lib/widgets/sanitize_gridtile.dart';
import 'package:user/Models/categories.dart';

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
      ),
    );
  }
}
