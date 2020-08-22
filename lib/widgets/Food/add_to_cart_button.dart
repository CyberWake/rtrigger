import 'package:flutter/material.dart';

import '../../models/apptheme.dart';

class AddToCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 90,
      decoration: BoxDecoration(
        color: AppTheme.dark_grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text("Add to Cart", style: TextStyle(color: Colors.white),),
    );
  }
}
