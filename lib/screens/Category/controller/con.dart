import 'package:flutter/foundation.dart';

class CatMenuBarCon extends ChangeNotifier {
  int _clickedIndex = 0;
  String _catSelected = "Brands";

  get clickedIndex {
    return _clickedIndex;
  }
  // yo index ma watch hanna parxaa .

  get catSelected {
    return _catSelected;
  }

  set setCatSelected(String name) {
    _catSelected = name;
    notifyListeners();
  }

  void changeIndex(int i) {
    _clickedIndex = i;
    notifyListeners();
  }

  void onTileTapped(index) {
    _clickedIndex = index;
    notifyListeners();
  }
}
