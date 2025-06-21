import 'dart:async';

import 'package:icheja_mobile/common/tts/domain/repositories/tts_repository.dart';

class GetIsSpeakingStreamUseCase {
  final TtsRepository _repository;

  GetIsSpeakingStreamUseCase(this._repository);

  Stream<bool> call() {
    return _repository.isSpeakingStream;
  }
}
