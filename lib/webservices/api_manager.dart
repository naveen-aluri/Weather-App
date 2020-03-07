import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:weatherapp/utils/constants.dart';

class ApiManager {
  static Dio dio() {
    Dio dio = new Dio(new BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ));
    dio.httpClientAdapter = new DefaultHttpClientAdapter();
    // dio.interceptors.add(LogInterceptor(responseBody: false));
    return dio;
  }
}
