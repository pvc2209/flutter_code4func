import 'package:bai29_flutter_app_bookstore/network/book_client.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';
import 'package:dio/dio.dart';

class OrderService {
  Future<Response> countShoppingCart() {
    return BookClient.instance.dio.get("/order/count");
  }

  Future<Response> addToCart(Product product) {
    return BookClient.instance.dio.post(
      "/order/add",
      data: product.toJson(),
    );
  }
}
