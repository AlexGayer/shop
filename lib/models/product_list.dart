import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = dummyProducts;

  bool _showFavoriteOnly = false;

  List<Product> get items {
    if (_showFavoriteOnly) {
      return _itens.where((product) => product.isFavorite).toList();
    }
    return [..._itens];
  }

  void addProduct(Product product) {
    _itens.add(product);
    notifyListeners();
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }
}
