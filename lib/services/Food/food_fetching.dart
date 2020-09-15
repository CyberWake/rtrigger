import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class FoodFetching {
  final _firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getFood(int index) async {
    List<dynamic> items = [];
    var allCollection = await _firestore.collection("vendorMenu").get();
    for (var document in allCollection.docs) {
      if (document.data()["combos"][index]["type"] == index) {
        var category = document.data()["combos"][index]["items"];
        if (category.length != 0) {
          for (var eachItem in category) {
            var distanceInMetre =
                await getDistance(eachItem["lat"], eachItem["long"]);
            var distance = distanceInMetre / 1000;
            eachItem["distance"] = distance.toInt();
            if (distance <= 10) {
              items.add(eachItem);
            }
          }
        }
      }
    }
    print(items);
    if (items.length != 0) {
      return items;
    } else {
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
