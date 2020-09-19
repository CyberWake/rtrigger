import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class FoodFetching {
  final _firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getFood(int index) async {
    List<dynamic> items = [];
    print(index);
    var allCollection = await _firestore.collection("vendorMenu").get();
    for (int i = 0; i < allCollection.docs.length; i++) {
      print(allCollection.docs[i].id);
      if (index < 14) {
        print(allCollection.docs[i].id);
        if (allCollection.docs[i].data()["combos"][index]["type"] == index) {
          var category = allCollection.docs[i].data()["combos"][index]["items"];
          if (category.length != 0) {
            for (var eachItem in category) {
              var distanceInMetre =
                  await getDistance(eachItem["lat"], eachItem["long"]);
              var distance = distanceInMetre / 1000;
              print(eachItem);
              eachItem["distance"] = distance.toInt();
              if (distance <= 10) {
                items.add(eachItem);
              }
            }
          }
        }
      } else {
        print("else");
        print(allCollection.docs[i].data()["combos"][index - 15]["type"]);
        if (allCollection.docs[i].data()["combos"][index - 15]["type"] ==
            index) {
          print("1");
          print(allCollection.docs[i].id);
          List<dynamic> category =
              allCollection.docs[i].data()["combos"][index - 15]["items"];
          print(category);
          if (category.length != 0) {
            for (var eachItem in category) {
              print("2");
              var distanceInMetre =
                  await getDistance(eachItem["lat"], eachItem["long"]);
              var distance = distanceInMetre / 1000;
              print(eachItem);
              eachItem["distance"] = distance.toInt();
              if (distance <= 10) {
                items.add(eachItem);
              }
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
