import 'dart:io';

import 'package:dio/dio.dart';
import 'package:icheja_mobile/auth/domain/entities/user_info_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserInfo> loginWithQr(File qrImage);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserInfo> loginWithQr(File qrImage) async {
    try {
      String fileName = qrImage.path.split('/').last;
      FormData formData = FormData.fromMap({
        "qrImage":
            await MultipartFile.fromFile(qrImage.path, filename: fileName),
      });

      final response = await dio.post(
        '/api/auth/login-student',
        data: formData,
      );

      return UserInfo.fromJson(response.data);
    } on DioException catch (e) {
      print('Dio error!');
      print('URL: ${e.requestOptions.uri}');
      print('Headers: ${e.requestOptions.headers}');
      print('Response: ${e.response}');
      rethrow;
    } catch (e) {
      print('Error sending image: $e');
      rethrow;
    }
  }
}
