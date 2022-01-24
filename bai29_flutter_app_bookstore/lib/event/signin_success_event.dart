import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/user_data.dart';

class SignInSuccessEvent extends BaseEvent {
  final UserData userData;

  SignInSuccessEvent(this.userData);
}
