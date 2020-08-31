import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class FoodFetching {
  final _firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getFood(int index) async {
      List<dynamic> items = [];
      var allCollection = await _firestore.collection("vendorMenu").get();
      for (var document in allCollection.docs) {
        if (document.get("combos")[index]["type"] == index) {
          var category = document.get("combos")[index]["items"];
          final distanceInMetre =
              await getDistance(category[0]['lat'], category[0]['long']);
          final distance = distanceInMetre / 1000;
          print("Category");
          print(category);
          final map = {
            'distance': distance,
            'price': category[0]['price'],
            'category': "Snacks",
            'prep': category[0]['prep'],
            'desc': "Delicious",
            'shop': category[0]['shop'],
            'productID':category[0]['productID'],
            'name': category[0]['item'],
            'timing': category[0]['timing'],
            'available': category[0]['available'],
            'img': category[0]['img'],
            'vendorId':category[0]['vendorId']
          };
          items.add(map);
        }
      }
      print(items);
      return items;
  }

  Future<double> getDistance(latitude, longitude) async {
    final myLocation = await Geolocator().getCurrentPosition();
    final myLatitude = myLocation.latitude;
    final myLongitude = myLocation.longitude;
    final distance = await Geolocator()
        .distanceBetween(myLatitude, myLongitude, latitude, longitude);
    return distance;
  }
}
