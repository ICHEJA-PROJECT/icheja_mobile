import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/stop_usecase.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/exercises/domain/entities/correlation_exercise.dart';
import 'package:icheja_mobile/exercises/data/mock/correlation_mock.dart';

class CorrelationExerciseViewModel extends ChangeNotifier {
  final SpeakUseCase speakUseCase;
  final StopUseCase stopUseCase;
  final GetIsSpeakingStreamUseCase getIsSpeakingStreamUseCase;
  final SessionManager sessionManager;

  late final StreamSubscription<bool> _isSpeakingSubscription;
  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _username;
  String? get username => _username;

  CorrelationExercise? _currentExercise;
  CorrelationExercise? get currentExercise => _currentExercise;

  int? _selectedOption;
  int? get selectedOption => _selectedOption;

  bool _showFeedback = false;
  bool get showFeedback => _showFeedback;

  bool _isCorrect = false;
  bool get isCorrect => _isCorrect;

  CorrelationExerciseViewModel({
    required this.speakUseCase,
    required this.stopUseCase,
    required this.getIsSpeakingStreamUseCase,
    required this.sessionManager,
  }) {
    _isSpeakingSubscription = getIsSpeakingStreamUseCase().listen((isSpeaking) {
      _isSpeaking = isSpeaking;
      notifyListeners();
    });

    _init();
  }

  Future<void> _init() async {
    _username = await sessionManager.getUserName();
    await loadExercise();
    notifyListeners();
  }

  Future<void> loadExercise() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentExercise = CorrelationExercise.fromMap(correlationExerciseMock);
      _selectedOption = null;
      _showFeedback = false;
      _isCorrect = false;
    } catch (e) {
      _errorMessage = "Error al cargar el ejercicio";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> speak(String text) async {
    await speakUseCase(text);
  }

  Future<void> stop() async {
    await stopUseCase();
  }

  void selectOption(int index) {
    if (_showFeedback) return;

    _selectedOption = index;
    _showFeedback = true;
    _isCorrect = _currentExercise?.opcionCorrecta == index;
    notifyListeners();
  }

  void nextExercise() {
    _selectedOption = null;
    _showFeedback = false;
    _isCorrect = false;
    loadExercise();
  }

  void resetFeedback() {
    _selectedOption = null;
    _showFeedback = false;
    _isCorrect = false;
    notifyListeners();
  }

  @override
  void dispose() {
    stop();
    _isSpeakingSubscription.cancel();
    super.dispose();
  }
}
