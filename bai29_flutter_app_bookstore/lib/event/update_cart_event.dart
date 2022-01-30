import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/product.dart';

class UpdateCartEvent extends BaseEvent {
  final Product product;
  UpdateCartEvent(this.product);
}
