import 'package:bai29_flutter_app_bookstore/data/remote/order_service.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/shopping_cart.dart';
import 'package:dio/dio.dart';

class OrderRepo {
  final OrderService _orderService;

  OrderRepo({required orderService}) : _orderService = orderService;

  Future<ShoppingCart> addToCart(Product product) async {
    try {
      var response = await _orderService.addToCart(product);

      var shoppingCart = ShoppingCart.fromJson(response.data["data"]);

      return shoppingCart;
    } on DioError {
      // pass
    } catch (e) {
      // pass
    }

    return Future.error('Lỗi đặt hàng');
  }

  Future<ShoppingCart> getShoppingCartInfo() async {
    try {
      var response = await _orderService.countShoppingCart();
      var shoppingCart = ShoppingCart.fromJson(response.data["data"]);

      return shoppingCart;
    } on DioError {
      // pass
    } catch (e) {
      // pass
    }

    return Future.error('Lỗi đơn hàng');
  }
}
