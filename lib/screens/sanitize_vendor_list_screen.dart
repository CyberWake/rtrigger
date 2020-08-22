import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/widgets/appbar_for_sanitizer_and_parlour_screen.dart';
import 'package:user/widgets/loading_bar.dart';
import 'package:user/widgets/vendor_list_item.dart';
import 'package:user/models/sanitizer_screen_categories.dart';

class VendorListScreen extends StatelessWidget {
  final Category category;
  VendorListScreen(this.category);
  String collectionName = '';

  @override
  Widget build(BuildContext context) {
    if (category == Category.sanitize)
      collectionName = 'vendorSanitize';
    else if (category == Category.cockroach)
      collectionName = 'vendorCockroach';
    else if (category == Category.mosquito) collectionName = 'vendorMosquito';

    listOfVendors();

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
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text('Sorry But There is No Vendor Near You'),
                    );
                  }
                  return VendorListItem(
                      vendorName: snapshot.data.docs[index].data()['name'],
                      location: snapshot.data.docs[index].data()['location'],
                      pricePerFeet: snapshot.data.docs[index]
                          .data()['pricePerFeet']
                          .toString(),
                      category: category,
                      uid: snapshot.data.docs[index].data()['uid']);
                });
          }
        },
      ),
    );
  }

  Future<QuerySnapshot> listOfVendors() async {
    final myLocation = await Geolocator().getCurrentPosition();
    final snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();
    snapshot.docs.forEach((element) {
      final latitude = element.data()['latitude'];
      final longitude = element.data()['longitude'];
      final distanceInMeters = Geolocator().distanceBetween(
          latitude, longitude, myLocation.latitude, myLocation.longitude);
      print(distanceInMeters);
    });
    return snapshot;
  }
}
