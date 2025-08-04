import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../services/woocommerce_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, value, child) {
        final cartItems =
            Provider.of<ProductsProvider>(context, listen: false).getUserCart();

        final subtotal = cartItems.entries
            .map((e) => double.tryParse(e.key.price)! * e.value)
            .fold(0.0, (a, b) => a + b);

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
                      'Oh, no. Go back to cart add product and then order!',
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
                          hintText: "Naam likh beta!",
                          keyboardType: TextInputType.name,
                          controller: fullNameController,
                        ),
                        const SizedBox(height: 16),
                        const Text("District / Jhela *"),
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
                          hintText: "Full bashar address mar!",
                          keyboardType: TextInputType.streetAddress,
                          controller: addressController,
                        ),
                        const SizedBox(height: 16),
                        const Text("Phone *"),
                        const SizedBox(height: 4),
                        MyTextField(
                          hintText: "01696969696",
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                        ),
                        const SizedBox(height: 16),
                        const Text("Email Address *"),
                        const SizedBox(height: 4),
                        MyTextField(
                          hintText: "Shob diso, email o diye deo mama!",
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                        const Text("Order notes (optional)"),
                        const SizedBox(height: 4),
                        MyTextField(
                          hintText:
                              "Notes about your order, e.g. special notes for delivery.",
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
                                    double.tryParse(product.price)! * quantity;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${product.name} × $quantity"),
                                      Text("${itemTotal.toStringAsFixed(0)}৳"),
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
                                  Text("${subtotal.toStringAsFixed(0)}৳"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Shipping"),
                                  Text(
                                    "GymJoy Courier: ${deliveryFee.toStringAsFixed(0)}৳",
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
                                    "${total.toStringAsFixed(0)}৳",
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
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Cash on Delivery",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color:
                                          Theme.of(
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
                    width:
                        MediaQuery.sizeOf(context).width >= 600
                            ? 600
                            : MediaQuery.sizeOf(context).width,
                    child: MaterialButton(
                      color: Theme.of(context).colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () async {
                        if (!isCashOnDelivery) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'We only accept Cash on Delivery! Please select the Cash on Delivery option to place your order!',
                              ),
                            ),
                          );
                          return;
                        }

                        // Extract the user input data
                        final fullName = fullNameController.text;
                        final address = addressController.text;
                        final district = districtController.text;
                        final phone = phoneController.text;
                        final email = emailController.text;
                        final notes = notesController.text;

                        // 1. Check if any required field is empty
                        if (fullName.isEmpty ||
                            address.isEmpty ||
                            district.isEmpty ||
                            phone.isEmpty ||
                            email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please fill out all the required fields!',
                              ),
                            ),
                          );
                          return;
                        }

                        // 2. Then check phone number validity
                        if (phone.length != 11 || !phone.startsWith('01')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Phone number should be 11 digits and must start with 01',
                              ),
                            ),
                          );
                          return;
                        }

                        // Get cart items
                        final cart =
                            Provider.of<ProductsProvider>(
                              context,
                              listen: false,
                            ).getUserCart();

                        // Show loading indicator
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Placing your order...'),
                          ),
                        );

                        // Call the WooCommerceService to create an order
                        final wooCommerceService = WooCommerceService();
                        final isOrderPlaced = await wooCommerceService
                            .createOrder(
                              cart: cart,
                              fullName: fullName,
                              address: address,
                              district: district,
                              phone: phone,
                              email: email,
                              notes: notes,
                            );

                        // Show success or failure message
                        if (isOrderPlaced) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Order placed successfully!'),
                              ),
                            );
                          }
                          if (context.mounted) {
                            Provider.of<ProductsProvider>(
                              context,
                              listen: false,
                            ).userCart.clear();
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Failed to place the order. Please try again.',
                                ),
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
