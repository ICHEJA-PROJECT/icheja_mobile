import 'package:dio/dio.dart';
import 'package:icheja_mobile/core/network/domain/constants/api_client_constants.dart';
import 'package:icheja_mobile/core/network/error_interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiClientConstants.baseAuthUrl,
        connectTimeout: ApiClientConstants.connectTimeout,
        receiveTimeout: ApiClientConstants.receiveTimeout,
      ),
    );

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    _dio.interceptors.add(ErrorInterceptor());
  }

  Dio get dio => _dio;
}
