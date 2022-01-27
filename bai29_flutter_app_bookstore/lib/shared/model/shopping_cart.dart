import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';

class ShoppingCart {
  String orderId;
  int total;
  List<Product>? productList;

  ShoppingCart({
    this.orderId = "",
    this.total = 0,
    this.productList,
  });

  factory ShoppingCart.fromJson(Map<String, dynamic> json) {
    return ShoppingCart(
      orderId: json["orderId"] ?? "",
      total: json["total"],
      productList: json["productList"],
    );
  }
}
