import 'package:bai29_flutter_app_bookstore/base/base_bloc.dart';
import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/order_repo.dart';
import 'package:bai29_flutter_app_bookstore/data/repo/product_repo.dart';
import 'package:bai29_flutter_app_bookstore/event/add_to_cart_event.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/shopping_cart.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  final ProductRepo _productRepo;
  final OrderRepo _orderRepo;

  var _shoppingCart = ShoppingCart();

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

  final _shoppingCartSubject = BehaviorSubject<ShoppingCart>();

  Stream<ShoppingCart> get shoppingCartStream => _shoppingCartSubject.stream;
  Sink<ShoppingCart> get shoppingCartSink => _shoppingCartSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case AddToCartEvent:
        handleAddToCartEvent(event as AddToCartEvent);
        break;
    }
  }

  void handleAddToCartEvent(AddToCartEvent event) {
    _orderRepo.addToCart(event.product).then((shoppingCart) {
      shoppingCart.orderId = _shoppingCart.orderId;

      shoppingCartSink.add(shoppingCart);
    }, onError: (e) {
      // TODO: giải quyết lỗi tương tự cách làm với user repo
    });
  }

  void getShoppingCartInfo() {
    // Ko hiểu sao phải dùng Stream ở đây, chỉ cần dùng .then là đc rồi mà.
    /*
    Stream<ShoppingCart>.fromFuture(_orderRepo.getShoppingCartInfo()).listen(
        (shoppingCart) {
      _shoppingCart = shoppingCart;

      // Demo delay để test trường hợp cart == null bên home_page.dart
      Future.delayed(const Duration(seconds: 3), () {
        shoppingCartSink.add(shoppingCart);
      });
    }, onError: (e) {
    });
    */

    _orderRepo.getShoppingCartInfo().then((shoppingCart) {
      _shoppingCart = shoppingCart;

      shoppingCartSink.add(shoppingCart);
    }, onError: (e) {
      // TODO: giải quyết lỗi tương tự cách làm với user repo
    });
  }

  Stream<List<Product>> getProductList() {
    // Test delay 5s để xem CircularProgressIndicator có ok ko?
    // return Stream<List<Product>>.fromFuture(Future.delayed(
    //     const Duration(seconds: 5), () => _productRepo.getProductList()));

    return Stream<List<Product>>.fromFuture(_productRepo.getProductList());
  }

  @override
  void dispose() {
    _shoppingCartSubject.close();
    super.dispose();
  }
}
