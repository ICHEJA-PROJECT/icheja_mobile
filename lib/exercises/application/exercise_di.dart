import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/exercises/data/datasources/exercise_local_data_source.dart';
import 'package:icheja_mobile/exercises/data/repositories/exercise_repository_impl.dart';
import 'package:icheja_mobile/exercises/domain/repositories/exercise_repository.dart';
import 'package:icheja_mobile/exercises/domain/usecases/get_exercises.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';

void setupExerciseDependencies(GetIt getIt) {
  // Data sources
  getIt.registerLazySingleton<ExerciseLocalDataSource>(
      () => ExerciseLocalDataSourceImpl());

  // Repositories
  getIt.registerLazySingleton<ExerciseRepository>(
      () => ExerciseRepositoryImpl(localDataSource: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetExercises(getIt()));

  // ViewModels
  getIt.registerFactory(() => ExerciseViewModel(
        getExercises: getIt(),
        speakUseCase: getIt(),
        stopUseCase: getIt(),
        getIsSpeakingStreamUseCase: getIt(),
        startRecordingUseCase: getIt(),
        stopRecordingUseCase: getIt(),
        getIsRecordingStreamUseCase: getIt(),
        playAudioUseCase: getIt(),
        stopAudioUseCase: getIt(),
        getIsPlayingStreamUseCase: getIt(),
        takePictureUseCase: getIt(),
      ));
}
