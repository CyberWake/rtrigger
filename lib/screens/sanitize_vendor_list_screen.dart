import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/widgets/appbar_for_sanitizer_and_parlour_screen.dart';
import 'package:user/widgets/loading_bar.dart';
import 'package:user/widgets/sanitize_vendor_list_item.dart';
import 'package:user/models/categories_enum.dart';

class SanitizeVendorListScreen extends StatelessWidget {
  final SanitizeCategory category;
  SanitizeVendorListScreen(this.category);
  String collectionName;

  @override
  Widget build(BuildContext context) {
    if (category == SanitizeCategory.sanitize) {
      collectionName = 'vendorSanitize';
    } else if (category == SanitizeCategory.cockroach) {
      collectionName = 'vendorCockroach';
    } else {
      collectionName = 'vendorMosquito';
    }

    return Scaffold(
      appBar: AppBarForSanitizerAndParlourScreen(context),
      body: FutureBuilder<List<Map>>(
        future: listOfVendors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingBar();
          else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text('Sorry But There is No Vendor Near You'),
                    );
                  }
                  return SanitizeVendorListItem(
                    vendorName: snapshot.data[index]['name'],
                    location: snapshot.data[index]['location'],
                    pricePerFeet:
                        snapshot.data[index]['pricePerFeet'].toString(),
                    category: category,
                    uid: snapshot.data[index]['uid'],
                    kmFar: snapshot.data[index]['distance'],
                  );
                });
          }
        },
      ),
    );
  }

  Future<List<Map>> listOfVendors() async {
    final myLocation = await Geolocator().getCurrentPosition();
    final myLatitude = myLocation.latitude;
    final myLongitude = myLocation.longitude;
    List<Map> list = [];

    final snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();

    for (var sanitizeVendor in snapshot.docs) {
      final latitude = sanitizeVendor.data()['latitude'] as double;
      final longitude = sanitizeVendor.data()['longitude'] as double;

      final distanceInMeter =
          await getDistance(myLatitude, myLongitude, latitude, longitude);
      final distance = distanceInMeter / 1000;
      final item = {
        'uid': sanitizeVendor.data()['uid'],
        'latitude': sanitizeVendor.data()['latitude'],
        'longitude': sanitizeVendor.data()['longitude'],
        'distance': distance,
        'name': sanitizeVendor.data()['name'],
        'location': sanitizeVendor.data()['location'],
        'pricePerFeet': sanitizeVendor.data()['pricePerFeet'],
      };
      list.add(item);
    }
    return list;
  }

  Future<double> getDistance(
      myLatitude, myLongitude, latitude, longitude) async {
    final distance = await Geolocator()
        .distanceBetween(myLatitude, myLongitude, latitude, longitude);
    return distance;
  }
}
