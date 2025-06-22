class ApiClientConstants {
  static const String baseAuthUrl = 'http://34.200.107.148:3000';
  static const String loginStudentPath = '/api/auth/login-student';
  static const String evaluateReadingExercisePath = 'http://34.200.107.148:5000/evaluate';

  static const Duration connectTimeout = Duration(milliseconds: 10000);
  static const Duration receiveTimeout = Duration(milliseconds: 10000);
}
