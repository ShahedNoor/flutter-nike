import 'package:flutter/material.dart';
import 'package:nike/components/product_tile.dart';
import 'package:nike/data/products.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // Add products to cart
  void addProductsToCart(ProductsModel products) {
    Provider.of<Products>(context, listen: false).addItemToCart(products);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Item added sucessfully to your cart!\nPlease check Your Cart.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder: (context, value, child) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),

            // Message
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 25.0,
              ),
              child: Text(
                'Pick from a selected list of premium products',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            // Hot picks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Hot Picks 🔥',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 440,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  ProductsModel products = value.getProductList()[index];
                  return ProductTile(
                    productsModel: products,
                    onTap: () => addProductsToCart(products),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
