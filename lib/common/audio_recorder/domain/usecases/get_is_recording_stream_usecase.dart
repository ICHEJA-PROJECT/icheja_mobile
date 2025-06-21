import 'dart:async';
import 'package:icheja_mobile/common/audio_recorder/domain/repositories/audio_recorder_repository.dart';

class GetIsRecordingStreamUseCase {
  final AudioRecorderRepository _repository;

  GetIsRecordingStreamUseCase(this._repository);

  Stream<bool> call() {
    return _repository.isRecordingStream;
  }
}
