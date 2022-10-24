// our notifier extents change notifier

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herb/screens/Category/models/product.dart';
import 'package:herb/screens/Homepage/firebase/firebase.dart';

// statenotifer
class fuck {}

class OurNotifier extends StateNotifier<fuck> {
  OurNotifier() : super(fuck());

// yesma k hudo rexa vanda sano sano aspect lai nai change garna parne rexaaa ...
// sano sano feature koni xutei xutei controller hunxa
  void f() {
    // state = [...state, todo];
    /// ...state vaenko chai previous wala state plus new  vaneko !
  }
}

/* class AppBarController extends StateNotifier<>{

} */

class HomeControlls extends ChangeNotifier {
  String _user = "User";

  get user {
    if (FirebaseAuth.instance.currentUser == null) {
      return _user;
    } else {
      return FirebaseAuth.instance.currentUser!.phoneNumber.toString();
    }
  }

  void changeUser() {
    _user = FirebaseAuth.instance.currentUser!.phoneNumber!;
    notifyListeners();
  }
}

class ProductControlls extends ChangeNotifier {
  ProductFuncs productFuncs = ProductFuncs();

  void addToCart(Product product) async {
    if (LoginDetails.isLoggedIn()) {
      await productFuncs.addToCart(LoginDetails.userid, product.id);
    } else {
      // tei signup page
    }
  }
}
