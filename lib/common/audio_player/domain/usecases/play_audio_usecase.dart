import 'package:icheja_mobile/common/audio_player/domain/repositories/audio_player_repository.dart';

class PlayAudioUseCase {
  final AudioPlayerRepository _repository;

  PlayAudioUseCase(this._repository);

  Future<void> call(String path) async {
    await _repository.play(path);
  }
}
