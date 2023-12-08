import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/product_list.dart';

enum filterOptions {
  Favorite,
  All,
}

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Loja"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == filterOptions.Favorite) {
                provider.showFavoriteOnly();
              } else {
                provider.showAll();
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: filterOptions.Favorite,
                child: Text("Somente favoritos"),
              ),
              PopupMenuItem(
                value: filterOptions.All,
                child: Text("Todos"),
              ),
            ],
          )
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
