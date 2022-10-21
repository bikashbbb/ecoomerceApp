import 'package:flutter/foundation.dart';

class NavController extends ChangeNotifier {
  int _navIndex = 0;

  void chnageNavIndex(int index) {
    _navIndex = index;
    notifyListeners();
  }

  get navIndex {
    return _navIndex;
  }
}
