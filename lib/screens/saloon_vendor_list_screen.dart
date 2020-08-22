import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_for_sanitizer_and_parlour_screen.dart';
import 'package:user/widgets/loading_bar.dart';
import 'package:user/widgets/saloon_gridtile.dart';

class SaloonVendorListScreen extends StatelessWidget {
  final SaloonCategory category;
  SaloonVendorListScreen(this.category);
  String _collectionName;

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case SaloonCategory.male:
        _collectionName = 'saloonVendorMale';
        break;

      case SaloonCategory.female:
        _collectionName = 'saloonVendorFemale';
        break;

      case SaloonCategory.unisex:
        _collectionName = 'saloonVendorUnisex';
        break;

      case SaloonCategory.spa:
        _collectionName = 'saloonVendorSpa';
        break;
    }

    return Scaffold(
      appBar: AppBarForSanitizerAndParlourScreen(context),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection(_collectionName).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingBar();
          } else {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.data.docs.length == 0)
                    return Center(
                      child: Text('Sorry But There are No Vendor Near You'),
                    );
                  else {}
                });
          }
        },
      ),
    );
  }
}
