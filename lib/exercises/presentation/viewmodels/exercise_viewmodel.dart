import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/stop_usecase.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/exercises/domain/entities/memorama_entity.dart';
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

  // ==========================================================================
  // PROPIEDADES GENERALES
  // ==========================================================================

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

  bool get isButtonForReadingEvaluationEnabled => _recordedFilePath != null;
  bool get isButtonForWritingEvaluationEnabled => takenPicture != null;

  // ==========================================================================
  // PROPIEDADES DEL EJERCICIO ACTUAL
  // ==========================================================================

  ExerciseEntity? _exerciseMock;
  ExerciseEntity? get exerciseMock => _exerciseMock;

  bool _isExerciseLoading = false;
  bool get isExerciseLoading => _isExerciseLoading;

  // ==========================================================================
  // PROPIEDADES PARA EJERCICIOS DE SELECCIÓN
  // ==========================================================================

  int? _selectedOption;
  int? get selectedOption => _selectedOption;

  bool _showFeedback = false;
  bool get showFeedback => _showFeedback;

  bool _isCorrect = false;
  bool get isCorrect => _isCorrect;

  // ==========================================================================
  // PROPIEDADES DEL MEMORAMA
  // ==========================================================================

  List<MemoramaCard> _memoramaCards = [];
  List<MemoramaCard> get memoramaCards => _memoramaCards;

  List<int> _selectedCards = [];
  bool _canSelectCard = true;
  int _matchedPairs = 0;
  bool _memoramaCompleted = false;
  bool get memoramaCompleted => _memoramaCompleted;

  int get totalMemoramaPairs => _memoramaCards.length ~/ 2;
  int get memoramaProgress => _matchedPairs;

  // Getter para verificar si el ejercicio actual es memorama
  bool get isCurrentExerciseMemory => _exerciseMock?.memoria == true;

  // ==========================================================================
  // CONSTRUCTOR
  // ==========================================================================

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
  }

  // ==========================================================================
  // MÉTODOS GENERALES
  // ==========================================================================

  Future<void> speak(String text) async {
    await speakUseCase(text);
  }

  Future<void> stop() async {
    await stopUseCase();
  }

  Future<void> getUsername() async {
    _username = await sessionManager.getUserName();
    notifyListeners();
  }

  void clearFeedback() {
    _evaluatedFeedback = null;
  }

  void _resetAudioState() {
    if (_isPlaying) stopPlayback();
    if (_isRecording) stopRecording();
    _recordedFilePath = null;
  }

  // ==========================================================================
  // MÉTODOS DE GRABACIÓN Y REPRODUCCIÓN
  // ==========================================================================

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

  Future<void> playRecording() async {
    if (_recordedFilePath != null) {
      await playAudioUseCase(_recordedFilePath!);
    }
  }

  Future<void> stopPlayback() async {
    await stopAudioUseCase();
  }

  // ==========================================================================
  // MÉTODOS DE CÁMARA
  // ==========================================================================

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

  // ==========================================================================
  // MÉTODOS DE EVALUACIÓN
  // ==========================================================================

  Future<void> evaluateListeningExercise() async {
    if (_recordedFilePath == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
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

  // ==========================================================================
  // MÉTODOS DE CARGA DE EJERCICIOS
  // ==========================================================================

  void loadExercise(String topicName, int exerciseIndex) async {
    _isExerciseLoading = true;
    _exerciseMock = null;
    _resetAllExerciseStates();
    notifyListeners();

    try {
      _exerciseMock = await getExerciseByIndexUseCase.call(
        topicName,
        exerciseIndex,
      );

      // Inicializar memorama si es necesario
      if (isCurrentExerciseMemory) {
        initializeMemoramaCards();
      }
    } catch (e) {
      _errorMessage = "Error loading exercise: ${e.toString()}";
      print('Error: $_errorMessage');
    } finally {
      _isExerciseLoading = false;
      notifyListeners();
    }
  }

  void _resetAllExerciseStates() {
    // Reset estados de selección
    _selectedOption = null;
    _showFeedback = false;
    _isCorrect = false;

    // Reset estados de memorama
    _resetMemoramaState();

    // Reset estados de audio y foto
    _resetAudioState();
    _takenPicture = null;

    // Reset feedback
    _evaluatedFeedback = null;
  }

  // ==========================================================================
  // MÉTODOS DE EJERCICIOS DE SELECCIÓN
  // ==========================================================================

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

  // ==========================================================================
  // MÉTODOS DEL MEMORAMA
  // ==========================================================================

  void initializeMemoramaCards() {
    if (!isCurrentExerciseMemory) return;

    final contexto = _exerciseMock?.contexto;
    if (contexto == null || contexto['contenido'] == null) return;

    final contenido = contexto['contenido'] as List<dynamic>;

    _memoramaCards.clear();
    _selectedCards.clear();
    _matchedPairs = 0;
    _memoramaCompleted = false;
    _canSelectCard = true;

    int cardId = 0;

    // Tomar solo los primeros 6 elementos para evitar demasiadas cartas
    final itemsToUse = contenido.take(6).toList();

    // Crear cartas de letras y señas
    for (final item in itemsToUse) {
      final letter =
          item['vocal'] as String? ?? item['minus_vocal'] as String? ?? '';
      final imageUrl = _cleanImageUrl(item['path_image'] as String? ?? '');

      if (letter.isNotEmpty && imageUrl.isNotEmpty) {
        // Carta con letra
        _memoramaCards.add(MemoramaCard(
          id: cardId++,
          content: letter,
          type: MemoramaCardType.letter,
          pairId: letter,
        ));

        // Carta con seña
        _memoramaCards.add(MemoramaCard(
          id: cardId++,
          content: imageUrl,
          type: MemoramaCardType.image,
          pairId: letter,
        ));
      }
    }

    // Mezclar las cartas
    _memoramaCards.shuffle(Random());
    notifyListeners();
  }

  String _cleanImageUrl(String url) {
    if (url.contains(':http')) {
      return url.split(':').last;
    }
    return url.trim();
  }

  void selectMemoramaCard(int cardIndex) {
    if (!_canSelectCard ||
        cardIndex >= _memoramaCards.length ||
        _memoramaCards[cardIndex].isFlipped ||
        _memoramaCards[cardIndex].isMatched ||
        _selectedCards.length >= 2) {
      return;
    }

    _memoramaCards[cardIndex] =
        _memoramaCards[cardIndex].copyWith(isFlipped: true);
    _selectedCards.add(cardIndex);

    if (_selectedCards.length == 2) {
      _canSelectCard = false;
      _checkMemoramaMatch();
    }

    notifyListeners();
  }

  void _checkMemoramaMatch() {
    Timer(const Duration(milliseconds: 1000), () {
      if (_selectedCards.length < 2) return;

      final firstCard = _memoramaCards[_selectedCards[0]];
      final secondCard = _memoramaCards[_selectedCards[1]];

      if (firstCard.pairId == secondCard.pairId) {
        // ¡Coincidencia!
        _memoramaCards[_selectedCards[0]] = firstCard.copyWith(isMatched: true);
        _memoramaCards[_selectedCards[1]] =
            secondCard.copyWith(isMatched: true);
        _matchedPairs++;

        // Verificar si el juego está completado
        if (_matchedPairs >= totalMemoramaPairs) {
          _memoramaCompleted = true;
        }
      } else {
        // No coinciden, voltear de nuevo
        _memoramaCards[_selectedCards[0]] =
            firstCard.copyWith(isFlipped: false);
        _memoramaCards[_selectedCards[1]] =
            secondCard.copyWith(isFlipped: false);
      }

      _selectedCards.clear();
      _canSelectCard = true;
      notifyListeners();
    });
  }

  void resetMemorama() {
    initializeMemoramaCards();
  }

  void _resetMemoramaState() {
    _memoramaCards.clear();
    _selectedCards.clear();
    _matchedPairs = 0;
    _memoramaCompleted = false;
    _canSelectCard = true;
  }

  // ==========================================================================
  // MÉTODOS DE NAVEGACIÓN (si se necesitan en el futuro)
  // ==========================================================================

  void nextExercise(String topicName, int nextIndex) {
    stop();
    _resetAllExerciseStates();
    loadExercise(topicName, nextIndex);
  }

  void previousExercise(String topicName, int previousIndex) {
    stop();
    _resetAllExerciseStates();
    loadExercise(topicName, previousIndex);
  }

  // ==========================================================================
  // DISPOSE
  // ==========================================================================

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
