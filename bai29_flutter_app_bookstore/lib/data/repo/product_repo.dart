import 'package:bai29_flutter_app_bookstore/data/remote/product_service.dart';

class ProductRepo {
  ProductService _productService;

  ProductRepo({required productService}) : _productService = productService;
}
