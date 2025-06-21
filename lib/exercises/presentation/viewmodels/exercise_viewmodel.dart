import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/stop_usecase.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/usecases/get_exercises.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/usecases/get_is_recording_stream_usecase.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/usecases/start_recording_usecase.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/usecases/stop_recording_usecase.dart';
import 'package:icheja_mobile/common/audio_player/domain/usecases/get_is_playing_stream_usecase.dart';
import 'package:icheja_mobile/common/audio_player/domain/usecases/play_audio_usecase.dart';
import 'package:icheja_mobile/common/audio_player/domain/usecases/stop_audio_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/take_picture_usecase.dart';

class ExerciseViewModel extends ChangeNotifier {
  final GetExercises getExercises;
  final SpeakUseCase speakUseCase;
  final StopUseCase stopUseCase;
  final GetIsSpeakingStreamUseCase getIsSpeakingStreamUseCase;
  final StartRecordingUseCase startRecordingUseCase;
  final StopRecordingUseCase stopRecordingUseCase;
  final GetIsRecordingStreamUseCase getIsRecordingStreamUseCase;
  final PlayAudioUseCase playAudioUseCase;
  final StopAudioUseCase stopAudioUseCase;
  final GetIsPlayingStreamUseCase getIsPlayingStreamUseCase;
  final TakePictureUseCase takePictureUseCase;

  late final StreamSubscription<bool> _isSpeakingSubscription;
  late final StreamSubscription<bool> _isRecordingSubscription;
  late final StreamSubscription<bool> _isPlayingSubscription;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Exercise> _exercises = [];
  int _currentExerciseIndex = 0;

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;

  bool _isRecording = false;
  bool get isRecording => _isRecording;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  String? _recordedFilePath;
  String? get recordedFilePath => _recordedFilePath;

  File? _takenPicture;
  File? get takenPicture => _takenPicture;

  bool _isInitialized = false;

  Exercise? get currentExercise =>
      _exercises.isNotEmpty ? _exercises[_currentExerciseIndex] : null;

  ExerciseViewModel({
    required this.getExercises,
    required this.speakUseCase,
    required this.stopUseCase,
    required this.getIsSpeakingStreamUseCase,
    required this.startRecordingUseCase,
    required this.stopRecordingUseCase,
    required this.getIsRecordingStreamUseCase,
    required this.playAudioUseCase,
    required this.stopAudioUseCase,
    required this.getIsPlayingStreamUseCase,
    required this.takePictureUseCase,
  }) {
    _isSpeakingSubscription = getIsSpeakingStreamUseCase().listen((isSpeaking) {
      _isSpeaking = isSpeaking;
      notifyListeners();
    });

    _isRecordingSubscription =
        getIsRecordingStreamUseCase().listen((isRecording) {
      _isRecording = isRecording;
      notifyListeners();
    });

    _isPlayingSubscription = getIsPlayingStreamUseCase().listen((isPlaying) {
      _isPlaying = isPlaying;
      notifyListeners();
    });

    loadExercises();
  }

  Future<void> speak(String text) async {
    await speakUseCase(text);
  }

  Future<void> stop() async {
    await stopUseCase();
  }

  Future<void> startRecording() async {
    if (_isPlaying) {
      await stopPlayback();
    }
    _recordedFilePath = null;
    await startRecordingUseCase();
  }

  Future<void> stopRecording() async {
    _recordedFilePath = await stopRecordingUseCase();
    notifyListeners();
  }

  Future<void> playRecording() async {
    if (_recordedFilePath != null) {
      await playAudioUseCase(_recordedFilePath!);
    }
  }

  Future<void> stopPlayback() async {
    await stopAudioUseCase();
  }

  Future<void> takePicture() async {
    final picture = await takePictureUseCase();
    if (picture != null) {
      _takenPicture = picture;
      notifyListeners();
    }
  }

  Future<void> loadExercises() async {
    if (_isInitialized) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _exercises = await getExercises();
      _currentExerciseIndex = 0; // Start at the first exercise
      _isInitialized = true;
    } catch (e) {
      _errorMessage = "Failed to load exercises.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _resetAudioState() {
    if (_isPlaying) stopPlayback();
    if (_isRecording) stopRecording();
    _recordedFilePath = null;
  }

  void nextExercise() {
    stop();
    _resetAudioState();
    _takenPicture = null;
    if (_currentExerciseIndex < _exercises.length - 1) {
      _currentExerciseIndex++;
    } else {
      _currentExerciseIndex = 0;
    }
    notifyListeners();
  }

  void previousExercise() {
    stop();
    _resetAudioState();
    _takenPicture = null;
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
    _resetAudioState();
    _isSpeakingSubscription.cancel();
    _isRecordingSubscription.cancel();
    _isPlayingSubscription.cancel();
    super.dispose();
  }
}
