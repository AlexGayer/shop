import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get intemsCount {
    return _items.length;
  }

  void removeItem(String productId) {
    items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
