import 'package:icheja_mobile/common/audio_recorder/domain/repositories/audio_recorder_repository.dart';

class StartRecordingUseCase {
  final AudioRecorderRepository _repository;

  StartRecordingUseCase(this._repository);

  Future<void> call() async {
    await _repository.startRecording();
  }
}
