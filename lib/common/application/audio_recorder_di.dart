import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/common/audio_recorder/data/repositories/audio_recorder_repository_impl.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/repositories/audio_recorder_repository.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/usecases/get_is_recording_stream_usecase.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/usecases/start_recording_usecase.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/usecases/stop_recording_usecase.dart';

void setupAudioRecorderDependencies(GetIt getIt) {
  // Repositories
  getIt.registerLazySingleton<AudioRecorderRepository>(
      () => AudioRecorderRepositoryImpl());

  // Use cases
  getIt.registerLazySingleton(() => StartRecordingUseCase(getIt()));
  getIt.registerLazySingleton(() => StopRecordingUseCase(getIt()));
  getIt.registerLazySingleton(() => GetIsRecordingStreamUseCase(getIt()));
}
