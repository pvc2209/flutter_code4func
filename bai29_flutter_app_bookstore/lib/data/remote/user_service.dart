import 'package:bai29_flutter_app_bookstore/network/book_client.dart';
import 'package:dio/dio.dart';

class UserService {
  Future<Response> signIn(String phone, String pass) {
    return BookClient.instance.dio.post(
      "/user/sign-in",
      data: {
        "phone": phone,
        "password": pass,
      },
    );
  }
}
