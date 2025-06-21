import 'dart:async';
import 'package:icheja_mobile/common/audio_player/domain/repositories/audio_player_repository.dart';

class GetIsPlayingStreamUseCase {
  final AudioPlayerRepository _repository;

  GetIsPlayingStreamUseCase(this._repository);

  Stream<bool> call() {
    return _repository.isPlayingStream;
  }
}
