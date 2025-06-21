import 'package:icheja_mobile/common/audio_recorder/domain/repositories/audio_recorder_repository.dart';

class StopRecordingUseCase {
  final AudioRecorderRepository _repository;

  StopRecordingUseCase(this._repository);

  Future<String?> call() async {
    return await _repository.stopRecording();
  }
}
