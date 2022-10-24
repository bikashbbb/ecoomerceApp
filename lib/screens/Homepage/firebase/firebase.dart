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
}

class ProductFuncs {
  final String _col = "cart";
  //
  Future<void> addToCart(String uid, String pid) async {
    return await FireCategories.firestore
        .collection(_col)
        .doc(uid)
        .collection("all")
        .doc()
        .set({"pId": pid});
  }
}
