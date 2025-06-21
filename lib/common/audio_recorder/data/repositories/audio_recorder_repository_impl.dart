import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/repositories/audio_recorder_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderRepositoryImpl implements AudioRecorderRepository {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final _isRecordingController = StreamController<bool>.broadcast();
  bool _isInitialized = false;

  final String _path = 'audio_recording.aac';

  @override
  Stream<bool> get isRecordingStream => _isRecordingController.stream;

  Future<void> _initialize() async {
    if (!_isInitialized) {
      await _recorder.openRecorder();
      _recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
      _isInitialized = true;
    }
  }

  @override
  Future<void> startRecording() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _initialize();
    await _recorder.startRecorder(toFile: _path, codec: Codec.aacADTS);
    _isRecordingController.add(true);
  }

  @override
  Future<String?> stopRecording() async {
    await _initialize();
    final path = await _recorder.stopRecorder();
    _isRecordingController.add(false);
    return path;
  }

  @override
  Future<void> dispose() async {
    if (_isInitialized) {
      await _recorder.closeRecorder();
      _isInitialized = false;
    }
    _isRecordingController.close();
  }
}

class RecordingPermissionException implements Exception {
  final String message;
  RecordingPermissionException(this.message);
}
