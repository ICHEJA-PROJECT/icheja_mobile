import 'package:icheja_mobile/common/audio_player/domain/repositories/audio_player_repository.dart';

class StopAudioUseCase {
  final AudioPlayerRepository _repository;

  StopAudioUseCase(this._repository);

  Future<void> call() async {
    await _repository.stop();
  }
}
