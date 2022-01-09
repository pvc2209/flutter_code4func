import 'package:bai29_flutter_app_bookstore/base/base_event.dart';

class SignInEvent extends BaseEvent {
  String phone;
  String pass;

  SignInEvent({required this.phone, required this.pass});
}
