import 'package:cloud_firestore/cloud_firestore.dart';

class FoodFetching{

  final _firestore = FirebaseFirestore.instance;

  Future getFood(int index) async{

    try{
      List<dynamic> items = [];
      var allCollection = await _firestore.collection("vendorMenu").get();
      for(var document in allCollection.docs){
        if(document.get("combos")[index]["type"]==index){
          var category = document.get("combos")[index]["items"];
          items.add(category[0]);
        }
      }
      print("**************returned**************");
      print(items);
      return items;
    }
    catch(e){
      print(e);
      return [];
    }
  }

}