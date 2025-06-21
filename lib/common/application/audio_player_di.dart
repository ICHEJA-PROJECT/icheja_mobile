import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/common/audio_player/data/repositories/audio_player_repository_impl.dart';
import 'package:icheja_mobile/common/audio_player/domain/repositories/audio_player_repository.dart';
import 'package:icheja_mobile/common/audio_player/domain/usecases/get_is_playing_stream_usecase.dart';
import 'package:icheja_mobile/common/audio_player/domain/usecases/play_audio_usecase.dart';
import 'package:icheja_mobile/common/audio_player/domain/usecases/stop_audio_usecase.dart';

void setupAudioPlayerDependencies(GetIt getIt) {
  // Repositories
  getIt.registerLazySingleton<AudioPlayerRepository>(
      () => AudioPlayerRepositoryImpl());

  // Use cases
  getIt.registerLazySingleton(() => PlayAudioUseCase(getIt()));
  getIt.registerLazySingleton(() => StopAudioUseCase(getIt()));
  getIt.registerLazySingleton(() => GetIsPlayingStreamUseCase(getIt()));
}
