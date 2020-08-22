import 'package:flutter/material.dart';

class SaloonServiceListTile extends StatelessWidget {
  final String service;
  final price;
  SaloonServiceListTile(this.service, this.price);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
        elevation: 7,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      service,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(price.toString() + ' Rs'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                elevation: 4,
                color: Color.fromRGBO(00, 44, 64, 1.0),
                textColor: Colors.white,
                height: screenHeight / 24,
                onPressed: () {},
                child: Text('Book Now'),
              ),
            )
          ],
        ));
  }
}