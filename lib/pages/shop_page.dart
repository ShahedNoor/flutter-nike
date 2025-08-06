import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import '../components/product_tile.dart';
import '../models/product.dart';
import '../providers/products_provider.dart';
import '../widgets/info_alert_dialog.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Message
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 25.0,
              ),
              child: Center(
                child: Text(
                  'Free Delivery\nFree standard delivery for members on orders \$80+',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),

            // Hot picks title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Featured Products 🔥',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => InfoAlertDialog(
                        message:
                            'See all feature is not available yet because we have only 1 product. Stay tuned for more! We are working on it! 😊',
                        messageHeight: 140,
                      ),
                    ),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Real-time product list
            SizedBox(
              height: 440,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .orderBy('timestamps.createdAt', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final productsDocs = snapshot.data?.docs ?? [];

                  if (productsDocs.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  final productsList = productsDocs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    // Merge document ID with the data
                    return Product.fromJson({'id': doc.id, ...data});
                  }).toList();

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productsList.length,
                    itemBuilder: (context, index) {
                      final product = productsList[index];

                      return ProductTile(
                        productsModel: product,
                        onTap: () async {
                          Provider.of<ProductsProvider>(
                            context,
                            listen: false,
                          ).addItemToCart(product);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Item added to cart!'),
                              duration: Duration(seconds: 1),
                            ),
                          );

                          if (await Vibration.hasVibrator()) {
                            Vibration.vibrate(duration: 50, amplitude: 1);
                          }
                        },
                      );
                    },
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
