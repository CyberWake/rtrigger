import 'package:flutter/material.dart';

Widget AppBarForSanitizerAndParlourScreen(final context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
    actions: <Widget>[
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 10),
          ],
        ),
      ),
      IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: () {},
        color: Colors.black,
      )
    ],
  );
}
