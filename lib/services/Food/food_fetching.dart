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
          print(category);
          if(category.length!=0){
            final distanceInMetre =
            await getDistance(double.parse(category[0]['lat']), double.parse(category[0]['long']));
            final distance = distanceInMetre / 1000;
            print("Category");
            category["distance"] = distance;
            print(category);
            items.add(category);
          }
//          final map = {
//            'distance': distance,
//            'price': category[index]['price'],
//            'category': "Snacks",
//            'prep': category[index]['prep'],
//            'desc': "Delicious",
//            'shop': category[index]['shop'],
//            'productID':category[0]['productID'],
//            'name': category[0]['item'],
//            'timing': category[0]['timing'],
//            'available': category[0]['available'],
//            'img': category[0]['img'],
//            'vendorId':category[0]['vendorId']
//          };
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
