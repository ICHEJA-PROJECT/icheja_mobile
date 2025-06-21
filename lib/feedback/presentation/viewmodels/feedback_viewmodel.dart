import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/stop_usecase.dart';

class FeedbackViewModel extends ChangeNotifier {
  final SpeakUseCase _speakUseCase;
  final StopUseCase _stopUseCase;
  final GetIsSpeakingStreamUseCase _getIsSpeakingStreamUseCase;
  StreamSubscription? _isSpeakingSubscription;

  FeedbackViewModel({
    required SpeakUseCase speakUseCase,
    required StopUseCase stopUseCase,
    required GetIsSpeakingStreamUseCase getIsSpeakingStreamUseCase,
  })  : _speakUseCase = speakUseCase,
        _stopUseCase = stopUseCase,
        _getIsSpeakingStreamUseCase = getIsSpeakingStreamUseCase {
    _isSpeakingSubscription =
        _getIsSpeakingStreamUseCase().listen((isSpeaking) {
      _isSpeaking = isSpeaking;
      notifyListeners();
    });
  }

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;

  void speak(String text) {
    _speakUseCase(text);
  }

  void stop() {
    _stopUseCase();
  }

  @override
  void dispose() {
    _isSpeakingSubscription?.cancel();
    _stopUseCase();
    super.dispose();
  }
}
