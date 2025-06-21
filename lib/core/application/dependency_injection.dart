import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/common/application/common_di.dart';
import 'package:icheja_mobile/exercises/application/exercise_di.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  setupCommonDependencies(getIt);
  setupExerciseDependencies(getIt);
}
