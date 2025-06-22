import 'dart:io';

import 'package:icheja_mobile/auth/data/datasources/auth_remote_data_source.dart';
import 'package:icheja_mobile/auth/domain/entities/user_info_entity.dart';
import 'package:icheja_mobile/auth/domain/repositories/auth_repository.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SessionManager sessionManager;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sessionManager,
  });

  @override
  Future<UserInfo> loginWithQr(File qrImage) async {
    final userInfo = await remoteDataSource.loginWithQr(qrImage);
    await sessionManager.saveSession(userInfo);
    return userInfo;
  }
}
