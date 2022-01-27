import 'package:bai29_flutter_app_bookstore/data/remote/order_service.dart';

class OrderRepo {
  final OrderService _orderService;

  OrderRepo({required orderService}) : _orderService = orderService;
}
