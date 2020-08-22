import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/models/categories_enum.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/loading_bar.dart';
import 'package:user/widgets/saloon_gridtile.dart';
import 'package:user/widgets/saloon_vendor_listtile.dart';

class SaloonVendorListScreen extends StatelessWidget {
  final SaloonCategory category;
  SaloonVendorListScreen(this.category);
  String _collectionName;

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case SaloonCategory.male:
        _collectionName = 'vendorSaloonMen';
        break;

      case SaloonCategory.female:
        _collectionName = 'vendorSaloonFemale';
        break;

      case SaloonCategory.unisex:
        _collectionName = 'vendorSaloonUnisex';
        break;

      case SaloonCategory.spa:
        _collectionName = 'vendorSaloonSpa';
        break;
    }

    return Scaffold(
      appBar: AppBarForSanitizerAndParlourScreen(context),
      body: FutureBuilder<List<Map>>(
        future: listOfVendors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingBar();
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return SaloonVendorListTile(
                      category: category,
                      vendorName: snapshot.data[index]['name'],
                      kmFar: snapshot.data[index]['distance'],
                      location: snapshot.data[index]['location'],
                      uid: snapshot.data[index]['uid'],
                      servicesList: snapshot.data[index]['services']);
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
        await FirebaseFirestore.instance.collection(_collectionName).get();

    for (var saloonVendor in snapshot.docs) {
      final latitude = saloonVendor.data()['latitude'] as double;
      final longitude = saloonVendor.data()['longitude'] as double;

      final distanceInMeter =
          await getDistance(myLatitude, myLongitude, latitude, longitude);
      final distance = distanceInMeter / 1000;
      final item = {
        'uid': saloonVendor.data()['uid'],
        'latitude': saloonVendor.data()['latitude'],
        'longitude': saloonVendor.data()['longitude'],
        'distance': distance,
        'name': saloonVendor.data()['name'],
        'location': saloonVendor.data()['location'],
        'services': saloonVendor.data()['services'] as List,
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
