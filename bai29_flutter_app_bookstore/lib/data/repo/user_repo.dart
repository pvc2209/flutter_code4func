import 'package:bai29_flutter_app_bookstore/data/remote/user_service.dart';
import 'package:bai29_flutter_app_bookstore/data/spref/spref.dart';
import 'package:bai29_flutter_app_bookstore/shared/model/user_data.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/constant.dart';
import 'package:dio/dio.dart';

class UserRepo {
  final UserService _userService;

  UserRepo({required UserService userService}) : _userService = userService;

  Future<UserData> signIn(String phone, String pass) async {
    try {
      var response = await _userService.signIn(phone, pass);

      if (response.data["code"] == 200) {
        var userData = UserData.fromJson(response.data["data"]);
        SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);

        return userData;
      }
    } on DioError catch (e) {
      // print(e);
    } catch (e) {
      // print(e);
    }

    // throw Exception("Đăng nhập thất bại");
    return Future.error('Đăng nhập thất bại');
  }

  Future<UserData> signUp(String displayName, String phone, String pass) async {
    try {
      var response = await _userService.signUp(displayName, phone, pass);

      if (response.data["code"] == 200) {
        var userData = UserData.fromJson(response.data["data"]);
        SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);

        return userData;
      }
    } on DioError catch (e) {
      // print(e);
    } catch (e) {
      // print(e);
    }

    return Future.error('Đăng ký thất bại');
  }
}
