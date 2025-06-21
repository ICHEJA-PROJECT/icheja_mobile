import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/domain/usecases/stop_usecase.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/usecases/get_exercises.dart';

class ExerciseViewModel extends ChangeNotifier {
  final GetExercises getExercises;
  final SpeakUseCase speakUseCase;
  final StopUseCase stopUseCase;
  final GetIsSpeakingStreamUseCase getIsSpeakingStreamUseCase;

  late final StreamSubscription<bool> _isSpeakingSubscription;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Exercise> _exercises = [];
  int _currentExerciseIndex = 0;

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;

  Exercise? get currentExercise =>
      _exercises.isNotEmpty ? _exercises[_currentExerciseIndex] : null;

  ExerciseViewModel({
    required this.getExercises,
    required this.speakUseCase,
    required this.stopUseCase,
    required this.getIsSpeakingStreamUseCase,
  }) {
    _isSpeakingSubscription = getIsSpeakingStreamUseCase().listen((isSpeaking) {
      _isSpeaking = isSpeaking;
      notifyListeners();
    });
  }

  Future<void> speak(String text) async {
    await speakUseCase(text);
  }

  Future<void> stop() async {
    await stopUseCase();
  }

  Future<void> loadExercises() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _exercises = await getExercises();
      final index = _exercises.indexWhere((ex) => ex.id == 1);
      _currentExerciseIndex = index != -1 ? index : 0;
    } catch (e) {
      _errorMessage = "Failed to load exercises.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void nextExercise() {
    stop();
    if (_currentExerciseIndex < _exercises.length - 1) {
      _currentExerciseIndex++;
    } else {
      _currentExerciseIndex = 0;
    }
    notifyListeners();
  }

  void previousExercise() {
    stop();
    if (_currentExerciseIndex > 0) {
      _currentExerciseIndex--;
    } else {
      _currentExerciseIndex = _exercises.length - 1;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    stop();
    _isSpeakingSubscription.cancel();
    super.dispose();
  }
}
