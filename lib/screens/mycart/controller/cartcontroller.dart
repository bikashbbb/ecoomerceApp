import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herb/screens/Category/models/product.dart';

class CartItems extends StateNotifier<List<Product>> {
  CartItems() : super([]);

  void addItem(Product product) {
    state.add(product);
  }
}
