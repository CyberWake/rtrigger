import 'package:flutter/material.dart';

Widget UniversalAppBar(final context) {
  return AppBar(
    backgroundColor: Colors.blueGrey,
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
