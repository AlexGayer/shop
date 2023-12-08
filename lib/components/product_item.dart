import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              onPressed: () => product.toggleFavorite(),
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.red,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.productDetail, arguments: product),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
