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
  }

  static final BookClient instance = BookClient._internal();

  Dio get dio => _dio;
}
