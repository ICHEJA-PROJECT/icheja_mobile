import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/stop_usecase.dart';
import 'package:icheja_mobile/home/domain/entities/progress_entity.dart';
import 'package:icheja_mobile/home/domain/usecases/get_progress.dart';

class HomeViewModel extends ChangeNotifier {
  final GetProgressUseCase _getProgressUseCase;
  final SpeakUseCase _speakUseCase;
  final StopUseCase _stopUseCase;
  final GetIsSpeakingStreamUseCase _getIsSpeakingStreamUseCase;
  StreamSubscription? _isSpeakingSubscription;

  HomeViewModel(
    this._getProgressUseCase,
    this._speakUseCase,
    this._stopUseCase,
    this._getIsSpeakingStreamUseCase,
  ) {
    fetchProgress();
    _isSpeakingSubscription =
        _getIsSpeakingStreamUseCase().listen((isSpeaking) {
      _isSpeaking = isSpeaking;
      notifyListeners();
    });
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ProgressEntity> _progressList = [];
  List<ProgressEntity> get progressList => _progressList;

  String? _error;
  String? get error => _error;

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;

  Future<void> fetchProgress() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _progressList = await _getProgressUseCase();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void speakProgress() {
    if (_progressList.isEmpty) return;

    final welcome = 'Bienvenido Fernando.';
    final progressParts = _progressList.map((p) {
      return 'Tu progreso en ${p.title} es del ${p.percentage} por ciento.';
    }).join(' ');

    _speakUseCase('$welcome $progressParts');
  }

  void stopSpeaking() {
    _stopUseCase();
  }

  @override
  void dispose() {
    _isSpeakingSubscription?.cancel();
    super.dispose();
  }
}
