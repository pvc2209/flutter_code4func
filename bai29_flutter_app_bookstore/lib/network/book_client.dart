import 'package:bai29_flutter_app_bookstore/data/spref/spref.dart';
import 'package:bai29_flutter_app_bookstore/shared/widget/constant.dart';
import 'package:dio/dio.dart';

class BookClient {
  // Khi request đến localhost khi run bằng Android Emulator
  // thì phải thay localhost thành 10.0.2.2
  static final BaseOptions _options = BaseOptions(
    baseUrl: "http://10.0.2.2:8000",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static final Dio _dio = Dio(_options);

  BookClient._internal() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));

    // Phiên bản mới của dio phải sử dụng như sau:
    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions myOption, RequestInterceptorHandler handler) async {
      var token = await SPref.instance.get(SPrefCache.KEY_TOKEN);
      if (token != null) {
        myOption.headers["Authorization"] = "Bearer " + token;
      }

      return handler.next(myOption);
    }));
  }

  static final BookClient instance = BookClient._internal();

  Dio get dio => _dio;
}
