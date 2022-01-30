import 'package:bai29_flutter_app_bookstore/data/remote/order_service.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/order.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/rest_error.dart';
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

    return Future.error(RestError.fromData('Lỗi AddToCart'));
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

    return Future.error(RestError.fromData('Lỗi lấy thông tin shopping cart'));
  }

  Future<Order> getOrderDetail(String orderId) async {
    try {
      var response = await _orderService.orderDetail(orderId);

      if (response.data["data"]["items"] != null) {
        var order = Order.fromJson(response.data["data"]);
        return order;
      }
    } on DioError catch (e) {
      // pass
    } catch (e, stacktrace) {
      print('Stacktrace: ' + stacktrace.toString());
    }

    return Future.error(RestError.fromData('Không lấy được đơn hàng'));
  }

  Future<bool> updateOrder(Product product) async {
    try {
      await _orderService.updateOrder(product);
      return true;
    } on DioError {
      // pass
    } catch (e) {
      // pass
    }

    return Future.error(RestError.fromData('Lỗi update đơn hàng'));
  }

  Future<bool> confirmOrder(String orderId) async {
    try {
      await _orderService.confirm(orderId);
      return true;
    } on DioError {
      // pass
    } catch (e) {
      // pass
    }

    return Future.error(RestError.fromData('Lỗi confirm đơn hàng'));
  }
}
