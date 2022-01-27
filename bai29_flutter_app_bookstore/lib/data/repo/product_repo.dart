import 'package:bai29_flutter_app_bookstore/data/remote/product_service.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/rest_error.dart';
import 'package:dio/dio.dart';

class ProductRepo {
  final ProductService _productService;

  ProductRepo({required productService}) : _productService = productService;

  Future<List<Product>> getProductList() async {
    try {
      var response = await _productService.getProductList();
      var productList = Product.parseProductList(response.data);

      return productList;
    } on DioError {
      // pass
    } catch (e) {
      // pass
    }

    return Future.error(RestError.fromData("Không có dữ liệu"));
  }
}
