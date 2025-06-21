import 'package:icheja_mobile/common/domain/repositories/tts_repository.dart';

class StopUseCase {
  final TtsRepository _repository;

  StopUseCase(this._repository);

  Future<void> call() async {
    await _repository.stop();
  }
}
