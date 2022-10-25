import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';

class FireCart {
  final String allproducts = "allproducts";

  Future<bool> isCartEmpty() async {
    /* final snap = await FireCategories.firestore
        .collection("users")
        .where("animals", arrayContains: "cat")
        .get();
    print(snap.docs[1].data()); */

    final snapshots = await FireCategories.firestore
        .collection(allproducts)
        .where("cart", arrayContains: LoginDetails.userid)
        .get();
    return snapshots.docs.isEmpty;
  }

  Query getAllProducts()  {
    final snap =  FireCategories.firestore
        .collection(allproducts)
        .where("cart", arrayContains: LoginDetails.userid);

    return snap ;
  }
}
// teslai future builder ma rakhne 
