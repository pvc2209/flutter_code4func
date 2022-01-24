import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/user_data.dart';

class SignUpSuccessEvent extends BaseEvent {
  final UserData userData;

  SignUpSuccessEvent(this.userData);
}
