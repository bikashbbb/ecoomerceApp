import 'package:flutter/widgets.dart';

class SortProductsControlls extends ChangeNotifier {
  final dropItems = ["Retail", "Wholesale"];
  String _hintName = "Retail";

  void onDropItemTapped(String name) {
    _hintName = name;
    notifyListeners();
  }

  get hintName {
    return _hintName;
  }
}

// product for you xutei collection banaune in the db !
