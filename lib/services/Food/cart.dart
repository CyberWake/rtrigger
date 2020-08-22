import 'package:cloud_firestore/cloud_firestore.dart';

class Cart{

  final _firestore = FirebaseFirestore.instance;


  Future<bool> addToCart({String userID, List item}) async{

    try{
      _firestore.collection("cart").doc(userID).update({
        "products": FieldValue.arrayUnion(item),
      });
      print("added to cart");
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }


  void deleteFromCart({String userID, String productID}) async{
    try{
      var products = await _firestore.collection("cart").doc(userID).get();
      List<dynamic> productItems = products.get("products");
      if(productItems!=null){
        for(var product in productItems){
          if(product["productID"]==productID){
            print(product);
            productItems.remove(product);
            break;
          }
        }
      }
      _firestore.collection("cart").doc(userID).set({
        "products": productItems,
      });
    }
    catch(e){
      print(e);
    }
  }

}