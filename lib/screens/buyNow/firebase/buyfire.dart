import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';
import 'package:herb/screens/buyNow/models/models.dart';

class BuyFirebase {
  Future<bool> onBuyNow(String pid, OrderDetails orderDetails) async {
    // check quanity it cannot be zero''
    // save the location also !
    try {
      final batch = FirebaseFirestore.instance.batch();
      // save phone email and location bitch next time tei use garne !
      // see if the prev location and it was not equal
      
      final orderRef =
          FireCategories.firestore.collection("allproducts").doc(pid);

      final orderDetailsRef =
          FireCategories.firestore.collection("OrderDetails").doc();

      batch.update(orderRef, {
        "Orders": FieldValue.arrayUnion([LoginDetails.userid])
      });

      batch.set(orderDetailsRef, OrderDetails.toMap(orderDetails));
      await batch.commit();
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
