import 'package:bai29_flutter_app_bookstore/base/base_bloc.dart';
import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/order_repo.dart';
import 'package:bai29_flutter_app_bookstore/event/confirm_order_event.dart';
import 'package:bai29_flutter_app_bookstore/event/pop_event.dart';
import 'package:bai29_flutter_app_bookstore/event/update_cart_event.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/order.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutBloc extends BaseBloc with ChangeNotifier {
  final OrderRepo _orderRepo;
  final String _orderId;

  final _orderSubject = BehaviorSubject<Order>();

  Stream<Order> get orderStream => _orderSubject.stream;
  Sink<Order> get orderSink => _orderSubject.sink;

  CheckoutBloc({required orderRepo, required orderId})
      : _orderRepo = orderRepo,
        _orderId = orderId;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case UpdateCartEvent:
        handleUpdateCart(event as UpdateCartEvent);
        break;
      case ConfirmOrderEvent:
        handleConfirmOrder(event as ConfirmOrderEvent);
        break;
    }
  }

  void handleUpdateCart(UpdateCartEvent event) {
    Stream.fromFuture(_orderRepo.updateOrder(event.product))
        .flatMap((_) => Stream.fromFuture(_orderRepo.getOrderDetail(_orderId)))
        .listen((order) {
      orderSink.add(order);
    });
  }

  void handleConfirmOrder(ConfirmOrderEvent event) {
    _orderRepo.confirmOrder(_orderId).then((isSuccess) {
      processEventSink.add(ShouldPopEvent());
    });
  }

  void getOrderDetail(String orderId) {
    Stream<Order>.fromFuture(
      _orderRepo.getOrderDetail(_orderId),
    ).listen((order) {
      orderSink.add(order);
    });
  }

  @override
  void dispose() {
    print("Checkout dispose!!!");

    super.dispose();
    _orderSubject.close();
  }
}
