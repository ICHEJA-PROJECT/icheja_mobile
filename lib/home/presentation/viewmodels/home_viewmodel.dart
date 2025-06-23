import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/domain/constants/ui_constants.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/stop_usecase.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/home/domain/entities/progress_entity.dart';
import 'package:icheja_mobile/home/domain/usecases/get_progress.dart';

class HomeViewModel extends ChangeNotifier {
  final GetProgressUseCase _getProgressUseCase;
  final SpeakUseCase _speakUseCase;
  final StopUseCase _stopUseCase;
  final GetIsSpeakingStreamUseCase _getIsSpeakingStreamUseCase;
  final SessionManager _sessionManager;
  StreamSubscription? _isSpeakingSubscription;

  HomeViewModel(
    this._getProgressUseCase,
    this._speakUseCase,
    this._stopUseCase,
    this._getIsSpeakingStreamUseCase,
    this._sessionManager,
  ) {
    _fetchUsername();
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

  String? _username;
  String? get username => _username;

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;

  Future<void> _fetchUsername() async {
    _username = await _sessionManager.getUserName();
    notifyListeners();
  }

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

    final welcome = 'Bienvenido ${_username ?? ''}.';
    final progressParts = _progressList.map((p) {
      return 'Tu progreso en ${p.title} es del ${p.percentage} por ciento.';
    }).join(' ');
    final instructions = "$progressParts ${UIConstants.homeMessage}";
    _speakUseCase('$welcome $instructions');
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
