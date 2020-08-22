import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/loading_bar.dart';
import 'package:user/widgets/vendor_list_item.dart';

class SanitizeVendorListScreen extends StatelessWidget {
  final Category category;
  SanitizeVendorListScreen(this.category);
  String collectionName = '';

  @override
  Widget build(BuildContext context) {
    if (category == Category.sanitize)
      collectionName = 'vendorSanitize';
    else if (category == Category.cockroach)
      collectionName = 'vendorCockroach';
    else if (category == Category.mosquito) collectionName = 'vendorMosquito';

    return Scaffold(
      appBar: AppBarForSanitizerAndParlourScreen(context),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection(collectionName).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingBar();
          else {
            return ListView.builder(
                itemCount: snapshot.data.docs.length == 0
                    ? 0
                    : snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return VendorListItem(
                      vendorName: snapshot.data.docs[index].data()['name'],
                      location: snapshot.data.docs[index].data()['location'],
                      pricePerFeet:
                          snapshot.data.docs[index].data()['pricePerFeet'].toString(),
                      category: category,
                      uid: snapshot.data.docs[index].data()['uid']);
                });
          }
        },
      ),
    );
  }
}
