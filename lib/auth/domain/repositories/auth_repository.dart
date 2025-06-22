import 'dart:io';

import 'package:icheja_mobile/auth/domain/entities/user_info_entity.dart';

abstract class AuthRepository {
  Future<UserInfo> loginWithQr(File qrImage);
}
