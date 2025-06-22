import 'dart:io';

import 'package:icheja_mobile/auth/domain/entities/user_info_entity.dart';
import 'package:icheja_mobile/auth/domain/repositories/auth_repository.dart';

class LoginWithQrUseCase {
  final AuthRepository repository;

  LoginWithQrUseCase({required this.repository});

  Future<UserInfo> call(File qrImage) {
    return repository.loginWithQr(qrImage);
  }
}
