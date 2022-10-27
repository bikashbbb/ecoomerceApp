import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';
import 'package:herb/screens/buyNow/firebase/buyfire.dart';
import 'package:herb/screens/buyNow/models/models.dart';

class FireOrders {
  Query orderQUery() {
    final snap = FireCategories.firestore
        .collection("allproducts")
        .where("Orders", arrayContains: LoginDetails.userid);
    return snap;
  }

  static Future<OrderDetails> getOrderDetails(String pid) async {
    final snap = await FireCategories.firestore
        .collection("OrderDetails")
        .where("productId", isEqualTo: pid)
        .get();

    return OrderDetails.fromMap(snap.docs[0].data(), snap.docs[0].id);
  }

  static Future<bool> cancelOrder(String pid, String id) async {
    // batch use garna parcha
    try {
      final batch = FirebaseFirestore.instance.batch();

      batch.update(BuyFirebase.getOrderRef(pid), {
        "Orders": FieldValue.arrayRemove([LoginDetails.userid])
      });
      batch.delete(BuyFirebase.getOrderDetailsRef(id));
      await batch.commit();
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
