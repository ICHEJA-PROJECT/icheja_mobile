import 'package:icheja_mobile/common/domain/repositories/tts_repository.dart';

class SpeakUseCase {
  final TtsRepository _repository;

  SpeakUseCase(this._repository);

  Future<void> call(String text) async {
    await _repository.speak(text);
  }
}
