// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import '../models/products_model.dart';

// class WooCommerceService {
//   static const String baseUrl = 'https://gymjoy.gg/wp-json/wc/v3/products';
//   static const String consumerKey =
//       'ck_1fd220e740b9592fae445845e2c87ebb1c8c859d';
//   static const String consumerSecret =
//       'cs_2f47023832b17104a9cfd46e0bc0bdd241ce40db';

//   // Fetch products from WooCommerce
//   Future<List<ProductsModel>> fetchProducts() async {
//     final String credentials = base64Encode(
//       utf8.encode('$consumerKey:$consumerSecret'),
//     );
//     final response = await http.get(
//       Uri.parse(baseUrl),
//       headers: {'Authorization': 'Basic $credentials'},
//     );

//     if (response.statusCode == 200) {
//       List data = json.decode(response.body);
//       return data.map((item) => ProductsModel.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   // Create order with Cash on Delivery and delivery fee
//   Future<bool> createOrder({
//     required Map<ProductsModel, int> cart,
//     required String fullName,
//     required String address,
//     required String district,
//     required String phone,
//     required String email,
//     String? notes,
//   }) async {
//     final String credentials = base64Encode(
//       utf8.encode('$consumerKey:$consumerSecret'),
//     );
//     final url = Uri.parse('https://gymjoy.gg/wp-json/wc/v3/orders');

//     // Convert cart to line items
//     final List<Map<String, dynamic>> lineItems =
//         cart.entries.map((entry) {
//           return {'product_id': entry.key.id, 'quantity': entry.value};
//         }).toList();

//     // Add flat shipping fee
//     const deliveryFee = 30.0;
//     final List<Map<String, dynamic>> shippingLines = [
//       {
//         "method_id": "flat_rate",
//         "method_title": "GymJoy Courier",
//         "total": deliveryFee.toStringAsFixed(2), // as string
//       },
//     ];

//     // Build request body
//     final body = {
//       "payment_method": "cod",
//       "payment_method_title": "Cash on Delivery",
//       "set_paid": true,
//       "status": "processing",
//       "billing": {
//         "first_name": fullName,
//         "address_1": address,
//         "city": district,
//         "phone": phone,
//         "email": email,
//       },
//       "shipping": {
//         "first_name": fullName,
//         "address_1": address,
//         "city": district,
//         "phone": phone,
//       },
//       "line_items": lineItems,
//       "shipping_lines": shippingLines, // <-- Use the variable here
//       "customer_note": notes ?? "",
//       "meta_data": [
//         {"key": "_order_source", "value": "gymjoy_app"},
//       ],
//     };

//     // Send POST request to WooCommerce
//     final response = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Basic $credentials',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(body),
//     );

//     // Debug the response
//     debugPrint("Order response: ${response.statusCode} - ${response.body}");

//     return response.statusCode == 201;
//   }
// }
