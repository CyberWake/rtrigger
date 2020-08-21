import 'package:flutter/material.dart';

Widget AppBarForSanitizerAndParlourScreen(final context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
    leading: Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 8.397,
          height: double.infinity,
          child: Icon(
            Icons.dehaze,
            color: Colors.white,
          ),
          color: Color.fromRGBO(00, 44, 64, 1),
        ),
        Container(
          color: Colors.white,
        )
      ],
    ),
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
