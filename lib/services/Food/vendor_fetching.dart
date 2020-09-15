import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class VendorFetching {
  final _firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getVendors() async {
    List<dynamic> vendors = [];

    try {
      var vendorMenu = await _firestore.collection("vendorMenu").get();
      for (var vendor in vendorMenu.docs) {
        var vendorData =
            await _firestore.collection("vendorData").doc(vendor.id).get();
        var temp = vendorData.data();
        temp["vendorID"] = vendor.id;
        var distanceInMetre =
            await getDistance(temp["latitude"], temp["longitude"]);
        var distance = distanceInMetre / 1000;
        temp["distance"]=distance.toInt();
        if (distance <= 10) {
          vendors.add(temp);
        }
        print(temp["name"]);
      }
      if (vendors.length != 0) {
        return vendors;
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<dynamic>> getVendorItems(String vendorID) async {
    List<dynamic> foodItems = [];

    try {
      var vendorMenu =
          await _firestore.collection("vendorMenu").doc(vendorID).get();
      var itemsArray = vendorMenu.get("combos");
      for (var item in itemsArray) {
        for (var eachItem in item["items"]) {
          var distanceInMetre =
              await getDistance(eachItem["lat"], eachItem["long"]);
          var distance = distanceInMetre / 1000;
          eachItem["distance"]=distance.toInt();
          if (distance <= 10) {
            foodItems.add(eachItem);
          }
        }
      }
      print("Data fetched");
      if (foodItems.length != 0) {
        return foodItems;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<double> getDistance(latitude, longitude) async {
    print("Inside distance function...");
    final myLocation = await Geolocator().getCurrentPosition();
    final myLatitude = myLocation.latitude;
    final myLongitude = myLocation.longitude;
    final distance = await Geolocator()
        .distanceBetween(myLatitude, myLongitude, latitude, longitude);
    return distance;
  }
}
