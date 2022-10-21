import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';

/* class FIreCategory{

  Query getCategory(){
    FireCategories.firestore.
  }
} */

class ItemsPerCat {
  String colName = "allproducts";

  Query getProduct(String catname) {
   return FireCategories.firestore.collection(colName).where("category",isEqualTo: catname);
  }
}
