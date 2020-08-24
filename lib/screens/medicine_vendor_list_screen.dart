import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user/widgets/appbar_subcategory_screens.dart';
import 'package:user/widgets/loading_bar.dart';
import 'package:user/widgets/medicine_vendor_list_tile.dart';

class MedicineVendorListScreen extends StatelessWidget {
  final _collectionName = 'Medical';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(context, false, 'Shops Near You'),
      body: FutureBuilder<List<Map>>(
        future: listOfVendors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingBar();
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return MedicineVendorListTile(
                    uid: snapshot.data[index]['uid'],
                    vendorName: snapshot.data[index]['name'],
                    location: snapshot.data[index]['location'],
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
        await FirebaseFirestore.instance.collection(_collectionName).get();

    for (var medicineVendor in snapshot.docs) {
      final latitude = medicineVendor.data()['latitude'] as double;
      final longitude = medicineVendor.data()['longitude'] as double;

      final distanceInMeter =
          await getDistance(myLatitude, myLongitude, latitude, longitude);

      final distance = distanceInMeter / 1000;
      final item = {
        'uid': medicineVendor.data()['uid'],
        'distance': distance,
        'name': medicineVendor.data()['name'],
        'location': medicineVendor.data()['location'],
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
