import 'package:bai29_flutter_app_bookstore/base/base_event.dart';

class AddToCartEvent extends BaseEvent {
  int count;
  AddToCartEvent(this.count);
}
