import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';

class Order {
  final double total; // Tổng tiền phải thanh toán
  final List<Product> items;

  Order({required this.total, required this.items});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        total: double.parse(json["total"].toString()),
        items: parseProductList(json));
  }

  static List<Product> parseProductList(Map<String, dynamic> json) {
    var list = json['items'] as List;
    return list.map((product) => Product.fromJson(product)).toList();
  }
}
