import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/exercises/data/datasources/exercise_local_data_source.dart';
import 'package:icheja_mobile/exercises/data/repositories/exercise_repository_impl.dart';
import 'package:icheja_mobile/exercises/domain/repositories/exercise_repository.dart';
import 'package:icheja_mobile/exercises/domain/usecases/get_exercises.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';

void setupExerciseDependencies(GetIt sl) {
  // ViewModel
  sl.registerLazySingleton(() => ExerciseViewModel(
        getExercises: sl(),
        speakUseCase: sl(),
        stopUseCase: sl(),
        getIsSpeakingStreamUseCase: sl(),
        startRecordingUseCase: sl(),
        stopRecordingUseCase: sl(),
        getIsRecordingStreamUseCase: sl(),
        playAudioUseCase: sl(),
        stopAudioUseCase: sl(),
        getIsPlayingStreamUseCase: sl(),
      ));

  // Usecases
  sl.registerLazySingleton(() => GetExercises(sl()));

  // Repositories
  sl.registerLazySingleton<ExerciseRepository>(
      () => ExerciseRepositoryImpl(localDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<ExerciseLocalDataSource>(
      () => ExerciseLocalDataSourceImpl());
}
