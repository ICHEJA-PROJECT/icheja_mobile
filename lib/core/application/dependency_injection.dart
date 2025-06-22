import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/auth/application/auth_di.dart';
import 'package:icheja_mobile/common/application/audio_player_di.dart';
import 'package:icheja_mobile/common/application/audio_recorder_di.dart';
import 'package:icheja_mobile/common/application/camera_di.dart';
import 'package:icheja_mobile/common/application/common_di.dart';
import 'package:icheja_mobile/core/network/dio_client.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/exercises/application/exercise_di.dart';
import 'package:icheja_mobile/home/application/home_di.dart';
import 'package:icheja_mobile/feedback/application/feedback_di.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // Core
  sl.registerLazySingleton(() => SessionManager(sl()));
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton(() => sl<DioClient>().dio);

  setupCommonDependencies(sl);
  setupExerciseDependencies(sl);
  setupHomeDependencies(sl);
  setupCameraDI(sl);
  setupAudioRecorderDependencies(sl);
  setupAudioPlayerDependencies(sl);
  setupFeedbackDependencies(sl);
  setupAuthDI(sl);
}
