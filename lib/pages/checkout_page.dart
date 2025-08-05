import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/my_text_field.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isCashOnDelivery = true;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    districtController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> placeOrder(Map cart) async {
    final ordersCollection = FirebaseFirestore.instance.collection('orders');

    final orderData = {
      'fullName': fullNameController.text.trim(),
      'district': districtController.text.trim(),
      'address': addressController.text.trim(),
      'phone': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'notes': notesController.text.trim(),
      'paymentMethod': isCashOnDelivery ? 'Cash on Delivery' : 'Other',
      'cart': cart.entries.map((entry) {
        final product = entry.key;
        final quantity = entry.value;
        return {
          'productId': product.id,
          'name': product.name,
          'price': product.pricing.basePrice,
          'quantity': quantity,
          'subtotal': product.pricing.basePrice * quantity,
        };
      }).toList(),
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'pending',
    };

    await ordersCollection.add(orderData);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, value, child) {
        final cartItems = value.getUserCart();

        final subtotal = cartItems.entries.fold<double>(
          0.0,
          (sum, entry) => sum + (entry.key.pricing.basePrice * entry.value),
        );

        final deliveryFee = 30.0;
        final total = subtotal + deliveryFee;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Checkout',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 10),
              if (cartItems.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'Oh, no. Go back to cart, add products and then order!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Text("Full Name *"),
                        const SizedBox(height: 4),
                        MyTextField(
                          hintText: "Your full name",
                          keyboardType: TextInputType.name,
                          controller: fullNameController,
                        ),
                        const SizedBox(height: 16),
                        const Text("District / Area *"),
                        const SizedBox(height: 4),
                        MyTextField(
                          hintText: "Ex: Dhaka",
                          keyboardType: TextInputType.streetAddress,
                          controller: districtController,
                        ),
                        const SizedBox(height: 16),
                        const Text("Full Address *"),
                        const SizedBox(height: 4),
                        MyTextField(
                          hintText: "Complete address",
                          keyboardType: TextInputType.streetAddress,
                          controller: addressController,
                        ),
                        const SizedBox(height: 16),
                        const Text("Phone *"),
                        const SizedBox(height: 4),
                        MyTextField(
                          hintText: "01XXXXXXXXX",
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                        ),
                        const SizedBox(height: 16),
                        const Text("Email Address *"),
                        const SizedBox(height: 4),
                        MyTextField(
                          hintText: "Your email address",
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                        const Text("Order notes (optional)"),
                        const SizedBox(height: 4),
                        MyTextField(
                          hintText: "Additional notes about your order",
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          controller: notesController,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Your Order",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Product",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              ...cartItems.entries.map((entry) {
                                final product = entry.key;
                                final quantity = entry.value;
                                final itemTotal =
                                    product.pricing.basePrice * quantity;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${product.name} × $quantity"),
                                      Text("\$${itemTotal.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                );
                              }),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Subtotal"),
                                  Text("\$${subtotal.toStringAsFixed(2)}"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Shipping"),
                                  Text(
                                    "Delivery Fee: \$${deliveryFee.toStringAsFixed(2)}",
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "\$${total.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isCashOnDelivery = !isCashOnDelivery;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: Row(
                              children: [
                                Radio<bool>(
                                  value: true,
                                  groupValue: isCashOnDelivery,
                                  onChanged: (value) {
                                    setState(() {
                                      isCashOnDelivery = value ?? true;
                                    });
                                  },
                                  activeColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Cash on Delivery",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Your phone number and location will be verified after placing an order with Cash on Delivery. If verification fails, your order will be canceled',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our privacy policy.",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              if (cartItems.isNotEmpty)
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.sizeOf(context).width >= 600
                        ? 600
                        : MediaQuery.sizeOf(context).width,
                    child: MaterialButton(
                      color: Theme.of(context).colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () async {
                        // Validation
                        if (!isCashOnDelivery) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'We only accept Cash on Delivery! Please select Cash on Delivery.',
                              ),
                            ),
                          );
                          return;
                        }

                        if (fullNameController.text.isEmpty ||
                            addressController.text.isEmpty ||
                            districtController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please fill out all the required fields!',
                              ),
                            ),
                          );
                          return;
                        }

                        if (phoneController.text.length != 11 ||
                            !phoneController.text.startsWith('01')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Phone number should be 11 digits and start with 01',
                              ),
                            ),
                          );
                          return;
                        }

                        try {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Placing your order...'),
                            ),
                          );

                          await placeOrder(cartItems);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Order placed successfully!'),
                              ),
                            );

                            // Clear cart after order
                            final provider = Provider.of<ProductsProvider>(
                              context,
                              listen: false,
                            );
                            // Remove all products from cart
                            final products = cartItems.keys.toList();
                            for (var product in products) {
                              provider.removeProductCompletely(product);
                            }

                            // Clear form
                            fullNameController.clear();
                            districtController.clear();
                            addressController.clear();
                            phoneController.clear();
                            emailController.clear();
                            notesController.clear();
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to place order: $e'),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
