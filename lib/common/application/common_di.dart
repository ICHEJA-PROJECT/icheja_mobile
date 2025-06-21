import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/common/data/repositories/tts_repository_impl.dart';
import 'package:icheja_mobile/common/domain/repositories/tts_repository.dart';
import 'package:icheja_mobile/common/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/domain/usecases/stop_usecase.dart';

void setupCommonDependencies(GetIt getIt) {
  // External
  getIt.registerLazySingleton<FlutterTts>(() => FlutterTts());

  // Repositories
  getIt.registerLazySingleton<TtsRepository>(() => TtsRepositoryImpl(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => SpeakUseCase(getIt()));
  getIt.registerLazySingleton(() => StopUseCase(getIt()));
  getIt.registerLazySingleton(() => GetIsSpeakingStreamUseCase(getIt()));
}
