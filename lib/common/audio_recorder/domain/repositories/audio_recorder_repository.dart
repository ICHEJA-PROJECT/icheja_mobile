import 'dart:async';

abstract class AudioRecorderRepository {
  Stream<bool> get isRecordingStream;
  Future<void> startRecording();
  Future<String?> stopRecording();
  Future<void> dispose();
}
