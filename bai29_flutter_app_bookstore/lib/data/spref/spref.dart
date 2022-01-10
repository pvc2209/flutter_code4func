import 'package:shared_preferences/shared_preferences.dart';

class SPref {
  SPref._internal();
  static final SPref instance = SPref._internal();

  Future<void> set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, value);
  }

  // Theo suy luận thì chỗ này kiểu trả về nên là Future<dynamic>
  // test thử thì đúng là Future<dynamic> thật :)
  Future<dynamic> get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(key);
  }
}
