import 'package:flutter/material.dart';
import 'package:user/sanitizer/utilities/categories.dart';

class VendorListItem extends StatelessWidget {
  final String vendorName;
  final String location;
  final String pricePerFeet;
  final Category category;
  VendorListItem(
      {@required this.vendorName,
      @required this.location,
      @required this.pricePerFeet,
      @required this.category});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(4),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                'Keshav Rathore',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                'Delhi,trinagar',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                'Price Per Sq. Foot : ',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              elevation: 4,
              color: Color.fromRGBO(00, 44, 64, 1.0),
              textColor: Colors.white,
              height: screenHeight / 22,
              minWidth: screenWidth,
              onPressed: () {},
              child: Text('ORDER NOW'),
            )
          ]),
        ),
      ),
    );
  }
}
