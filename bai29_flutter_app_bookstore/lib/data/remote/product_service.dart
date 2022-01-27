import 'package:bai29_flutter_app_bookstore/network/book_client.dart';
import 'package:dio/dio.dart';

class ProductService {
  Future<Response> getProductList() {
    return BookClient.instance.dio.get("/product/list");
  }
}
