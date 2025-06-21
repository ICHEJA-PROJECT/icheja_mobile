import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/common/application/audio_player_di.dart';
import 'package:icheja_mobile/common/application/audio_recorder_di.dart';
import 'package:icheja_mobile/common/application/camera_di.dart';
import 'package:icheja_mobile/common/application/common_di.dart';
import 'package:icheja_mobile/exercises/application/exercise_di.dart';
import 'package:icheja_mobile/home/application/home_di.dart';

final sl = GetIt.instance;

void setupDependencies() {
  setupCommonDependencies(sl);
  setupExerciseDependencies(sl);
  setupHomeDependencies(sl);
  setupCameraDependencies(sl);
  setupAudioRecorderDependencies(sl);
  setupAudioPlayerDependencies(sl);
}
