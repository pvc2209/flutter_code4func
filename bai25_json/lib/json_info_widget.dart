import 'dart:convert';

import 'package:flutter/material.dart';

import 'order.dart';

const jsonString = '''
{
  "orderId": 123,
  "user": {
    "fullName": "pvc",
    "email": "pvc@gmail.com"
  },
  "products": [
    {
      "productId": 1,
      "productName": "Macbook",
      "quantity": 10,
      "price": 999.1
    },
    {
      "productId": 2,
      "productName": "Iphone",
      "quantity": 100,
      "price": 999.99
    },
    {
      "productId": 3,
      "productName": "Xiaoxin",
      "quantity": 1,
      "price": 9999.99
    }
  ]
}
''';

class JsonInfoWidget extends StatelessWidget {
  const JsonInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // https://app.quicktype.io/
            Map<String, dynamic> json = jsonDecode(jsonString);
            // print(map["products"]);

            var order = Order.fromJson(json);

            print(order.orderId);
            print(order.user.email);
            print(order.user.fullName);
            print("---------------");

            for (var product in order.products) {
              print(product.productName);
            }
          },
          child: const Text("Click"),
        ),
      ),
    );
  }
}
