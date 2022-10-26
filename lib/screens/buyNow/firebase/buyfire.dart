import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';
import 'package:herb/screens/buyNow/models/models.dart';

class BuyFirebase {
  Future<bool> onBuyNow(OrderDetails orderDetails) async {
    // check quanity it cannot be zero''
    // save the location also !
    try {
      final batch = FirebaseFirestore.instance.batch();
/*       final locationRef =
          FireCategories.firestore.collection("users").doc(LoginDetails.userid);
 */ // save phone email and location bitch next time tei use garne !
      final orderRef = FireCategories.firestore
          .collection("allproducts")
          .doc(orderDetails.productId);

      final orderDetailsRef =
          FireCategories.firestore.collection("OrderDetails").doc();

      batch.update(orderRef, {
        "Orders": FieldValue.arrayUnion([LoginDetails.userid])
      });

      batch.set(orderDetailsRef, OrderDetails.toMap(orderDetails));

      /* batch.set(locationRef, {
        orderDetails.location
      }); */
      await batch.commit();
      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
