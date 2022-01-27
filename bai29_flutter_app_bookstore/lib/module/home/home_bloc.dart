import 'package:bai29_flutter_app_bookstore/base/base_bloc.dart';
import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/order_repo.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/product_repo.dart';
import 'package:bai29_flutter_app_bookstore/event/add_to_cart_event.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  final ProductRepo _productRepo;
  final OrderRepo _orderRepo;

  static HomeBloc? _instance;

  static HomeBloc getInstance(
      {required ProductRepo productRepo, required OrderRepo orderRepo}) {
    // Cách bình thường:
    // _instance ??=
    //     HomeBloc._internal(productRepo: productRepo, orderRepo: orderRepo);
    // return _instance!;

    // Cách pro vip: nếu _instance là null thì _instance gán = HomeBloc._internal
    // và return lại _instance, ngược lại return _instance luôn
    return _instance ??=
        HomeBloc._internal(productRepo: productRepo, orderRepo: orderRepo);
  }

  // Biến HomeBloc thành Singleton
  HomeBloc._internal(
      {required ProductRepo productRepo, required OrderRepo orderRepo})
      : _productRepo = productRepo,
        _orderRepo = orderRepo;

  final _shoppingCartSubject = BehaviorSubject<AddToCartEvent>();

  Stream<AddToCartEvent> get shoppingCartStream => _shoppingCartSubject.stream;
  Sink<AddToCartEvent> get shoppingCartSink => _shoppingCartSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case AddToCartEvent:
        handleAddToCartEvent(event as AddToCartEvent);
        break;
    }
  }

  static int count = 0;
  void handleAddToCartEvent(AddToCartEvent event) {
    ++count;
    print(count);

    event.count = count;
    shoppingCartSink.add(event);
  }

  @override
  void dispose() {
    _shoppingCartSubject.close();
    super.dispose();
  }
}
