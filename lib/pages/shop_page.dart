import 'package:flutter/material.dart';
import 'package:nike/components/shoe_tile.dart';
import 'package:nike/data/products.dart';

import '../models/shoe.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                Products products = Products();
                var product = products.products;
                // Init shoe model
                Shoe shoe = Shoe(
                  name: product[index]['name'].toUpperCase(),
                  price: product[index]['price'],
                  imagePath: product[index]['imagePath'],
                  description: product[index]['description'],
                );
                return ShoeTile(
                  shoe: shoe,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
