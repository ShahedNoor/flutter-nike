import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import '../components/product_tile.dart';
import '../models/products_model.dart';
import '../providers/products_provider.dart';
import '../widgets/info_alert_dialog.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsProvider>(
        context,
        listen: false,
      ).fetchProductsFromAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder:
          (context, value, child) => SafeArea(
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
                        'Welcome to NIKE\nWe are delivering all over the world at \$30 only!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
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
                          'Featured Products 🔥',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              () => showDialog(
                                context: context,
                                builder:
                                    (context) => InfoAlertDialog(
                                      message:
                                          'See all feature is not available yet because we have only 1 product. Stay tuned for more!'
                                          ' We are working on it! 😊',
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
                  SizedBox(
                    height: 440,
                    child:
                        value.isLoading
                            ? Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                            : ListView.builder(
                              itemCount: value.getProductList().length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                ProductsModel products =
                                    value.getProductList()[index];
                                return ProductTile(
                                  productsModel: products,
                                  onTap: () async {
                                    Provider.of<ProductsProvider>(
                                      context,
                                      listen: false,
                                    ).addItemToCart(products);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Item added to cart!'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );

                                    if (await Vibration.hasVibrator()) {
                                      Vibration.vibrate(
                                        duration: 50,
                                        amplitude: 1,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
