import 'package:icheja_mobile/auth/domain/entities/user_info_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final SharedPreferences _prefs;

  SessionManager(this._prefs);

  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';

  Future<void> saveSession(UserInfo userInfo) async {
    await _prefs.setString(_tokenKey, userInfo.token);
    await _prefs.setInt(_userIdKey, userInfo.id);
    await _prefs.setString(_userNameKey, userInfo.name);
  }

  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  Future<String?> getUserName() async {
    return _prefs.getString(_userNameKey);
  }

  Future<void> clearSession() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_userNameKey);
  }
}
