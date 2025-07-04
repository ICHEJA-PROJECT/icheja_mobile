import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/stop_usecase.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/exercises/domain/usecases/evaluate_reading_exercise_usecase.dart';
import 'package:icheja_mobile/exercises/domain/usecases/evaluate_writing_exercise_usecase.dart';
import 'package:icheja_mobile/exercises/domain/usecases/get_exercise_by_index.dart';
import 'package:icheja_mobile/exercises/domain/usecases/get_exercises.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/usecases/get_is_recording_stream_usecase.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/usecases/start_recording_usecase.dart';
import 'package:icheja_mobile/common/audio_recorder/domain/usecases/stop_recording_usecase.dart';
import 'package:icheja_mobile/common/audio_player/domain/usecases/get_is_playing_stream_usecase.dart';
import 'package:icheja_mobile/common/audio_player/domain/usecases/play_audio_usecase.dart';
import 'package:icheja_mobile/common/audio_player/domain/usecases/stop_audio_usecase.dart';
import 'package:icheja_mobile/home/domain/entities/topic_content_entity.dart';
import 'package:image_picker/image_picker.dart';

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
  final EvaluateReadingExerciseUseCase evaluateReadingExerciseUseCase;
  final EvaluateWritingExerciseUseCase evaluateWritingExerciseUseCase;
  final SessionManager sessionManager;
  final GetExerciseByIndexUseCase getExerciseByIndexUseCase;

  FeedbackEntity? _evaluatedFeedback;
  FeedbackEntity? get evaluatedFeedback => _evaluatedFeedback;

  late final StreamSubscription<bool> _isSpeakingSubscription;
  late final StreamSubscription<bool> _isRecordingSubscription;
  late final StreamSubscription<bool> _isPlayingSubscription;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _username;
  String? get username => _username;

  // List<Exercise> _exercises = [];
  // int _currentExerciseIndex = 0;

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

  // bool _isInitialized = false;

  bool get isButtonForReadingEvaluationEnabled => _recordedFilePath != null;
  bool get isButtonForWritingEvaluationEnabled => takenPicture != null;

  // Exercise? get currentExercise =>
  //     _exercises.isNotEmpty ? _exercises[_currentExerciseIndex] : null;

  ExerciseEntity? _exerciseMock;
  ExerciseEntity? get exerciseMock => _exerciseMock;

  bool _isExerciseLoading = false;
  bool get isExerciseLoading => _isExerciseLoading;

  int? _selectedOption;
  int? get selectedOption => _selectedOption;

  bool _showFeedback = false;
  bool get showFeedback => _showFeedback;

  bool _isCorrect = false;
  bool get isCorrect => _isCorrect;

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
    required this.evaluateReadingExerciseUseCase,
    required this.evaluateWritingExerciseUseCase,
    required this.sessionManager,
    required this.getExerciseByIndexUseCase,
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
    getUsername();
    // loadExercises();
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
    if (_recordedFilePath != null) {
      print('Recording file path: $_recordedFilePath');
    }
    notifyListeners();
  }

  Future<void> evaluateListeningExercise() async {
    if (_recordedFilePath == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // final exerciseCtx = currentExercise!.contexto as ReadingContext;
      final feedback = await evaluateReadingExerciseUseCase(
          audioPath: _recordedFilePath!,
          objectiveSentence: 'exerciseCtx.readingBase,');
      print('Feedback: $feedback');
      _evaluatedFeedback = feedback;
    } catch (e) {
      _errorMessage = "Error al evaluar el ejercicio: ${e.toString()}";
      print('Error: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> evaluateWritingExercise() async {
    if (_takenPicture == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // final exerciseCtx = currentExercise!.contexto as WritingContext;
      final feedback = await evaluateWritingExerciseUseCase(
        studentImage: _takenPicture!,
        originalImageUrl: 'exerciseCtx.imageBase',
      );
      _evaluatedFeedback = feedback;
      print('Writing exercise evaluation result: $feedback');
    } catch (e) {
      _errorMessage =
          "Error al evaluar el ejercicio de escritura: ${e.toString()}";
      print('Error: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      _takenPicture = File(imageFile.path);
      print('Picture taken: ${_takenPicture?.path}');
      notifyListeners();
    } else {
      print('No picture taken');
    }
  }

  Future<void> cleanPicture() async {
    _takenPicture = null;
    notifyListeners();
  }

  Future<void> getUsername() async {
    _username = await sessionManager.getUserName();
    notifyListeners();
  }

  // Future<void> loadExercises() async {
  //   if (_isInitialized) return;

  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();

  //   try {
  //     _exercises = await getExercises();
  //     _currentExerciseIndex = 0; // Start at the first exercise
  //     _isInitialized = true;
  //   } catch (e) {
  //     _errorMessage = "Failed to load exercises.";
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  void _resetAudioState() {
    if (_isPlaying) stopPlayback();
    if (_isRecording) stopRecording();
    _recordedFilePath = null;
  }

  // void nextExercise() {
  //   stop();
  //   _resetAudioState();
  //   _takenPicture = null;
  //   if (_currentExerciseIndex < _exercises.length - 1) {
  //     _currentExerciseIndex++;
  //   } else {
  //     _currentExerciseIndex = 0;
  //   }
  //   notifyListeners();
  // }

  // void previousExercise() {
  //   stop();
  //   _resetAudioState();
  //   _takenPicture = null;
  //   if (_currentExerciseIndex > 0) {
  //     _currentExerciseIndex--;
  //   } else {
  //     _currentExerciseIndex = _exercises.length - 1;
  //   }
  //   notifyListeners();
  // }

  void clearFeedback() {
    _evaluatedFeedback = null;
  }

  void loadExercise(String topicName, int exerciseIndex) async {
    _isExerciseLoading = true;
    _exerciseMock = null;
    notifyListeners();

    try {
      _exerciseMock = await getExerciseByIndexUseCase.call(
        topicName,
        exerciseIndex,
      );
    } catch (e) {
      _errorMessage = "Error loading exercise: ${e.toString()}";
      print('Error: $_errorMessage');
    } finally {
      _isExerciseLoading = false;
      notifyListeners();
    }
  }

  void selectOption(int index) {
    if (_showFeedback) return;

    final exerciseCtx = _exerciseMock?.contexto;

    _selectedOption = index;
    _showFeedback = true;
    _isCorrect = exerciseCtx?["opcion_correcta"] == index;
    notifyListeners();
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
    _resetAudioState();
    _isSpeakingSubscription.cancel();
    _isRecordingSubscription.cancel();
    _isPlayingSubscription.cancel();
  }
}
