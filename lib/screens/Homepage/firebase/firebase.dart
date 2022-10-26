import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireCategories {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static late CollectionReference _queryoutput;

  final Query = firestore.collection("Categories");
}

class FireProductForYou {
  /* Query getProducts(){

  } */
}

class FireImages {
  final fireStoreRef = FirebaseStorage.instance.ref('category photos');

  Future<void> requiredImage(String name) async {
    //String imageUrl = "";
    await fireStoreRef
        .child("pexels-mareefe-1638280.jpg")
        .getDownloadURL()
        .then((value) => print(value));
    /* print(imageUrl);
    return imageUrl; */
  }
}

class LoginDetails {
  static bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    }
    return true;
  }

  static get userid {
    return FirebaseAuth.instance.currentUser!.uid.toString();
  }

  static get phoneNum {
    return FirebaseAuth.instance.currentUser!.phoneNumber.toString();
  }
}

class ProductFuncs {
  final String _col = "allproducts";
  //
  Future<void> addToCart(String uid, String pid) async {
    // paila check if the pid is init or not !
    DocumentReference ref = FireCategories.firestore.collection(_col).doc(pid);
    await ref.update({
      "cart": FieldValue.arrayUnion([uid])
    });
  }

  Future<void> removeFromCart(String uid, String pid) async {
    DocumentReference ref = FireCategories.firestore.collection(_col).doc(pid);
    await ref.update({
      "cart": FieldValue.arrayRemove([uid])
    });
  }
}
// order vanne sec in ProductsForYou
// ani order details pani hunxa !