import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/get_is_speaking_stream_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/speak_usecase.dart';
import 'package:icheja_mobile/common/tts/domain/usecases/stop_usecase.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/exercises/data/models/memorama_exercise_model.dart';
import 'package:icheja_mobile/exercises/domain/entities/memorama_entity.dart';

class MemoramaViewModel extends ChangeNotifier {
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

  MemoramaExercise? _currentExercise;
  MemoramaExercise? get currentExercise => _currentExercise;

  List<MemoramaCard> _cards = [];
  List<MemoramaCard> get cards => _cards;

  List<int> _selectedCards = [];
  bool _canSelect = true;
  int _matchedPairs = 0;
  bool _gameCompleted = false;
  bool get gameCompleted => _gameCompleted;

  MemoramaViewModel({
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
      // Aquí cargarías el ejercicio desde tu data source
      // Por ahora uso datos mock basados en el JSON proporcionado
      _currentExercise = _createMockExercise();
      _initializeCards();
    } catch (e) {
      _errorMessage = "Error al cargar el ejercicio";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  MemoramaExercise _createMockExercise() {
    // Simular la carga del ejercicio desde el JSON
    final mockData = {
      "titulo": "¡Desafía tu Memoria: El Juego del Memorama!",
      "subtitulo": "¿Puedes encontrar los pares correctos antes que el tiempo se acabe?",
      "contenido": "Pon a prueba tu concentración y memoria visual...",
      "instrucciones": "Para jugar, encuentra las parejas que correspondan...",
      "contexto": {
        "contenido": [
          {"vocal": "A", "path_image": "http://res.cloudinary.com/dsiamqhuu/image/upload/v1751581287/ICHEJA/ICHEJA/T2_R1_1.svg"},
          {"vocal": "B", "path_image": "http://res.cloudinary.com/dsiamqhuu/image/upload/v1751581457/ICHEJA/ICHEJA/T2_R1_2.svg"},
          {"vocal": "C", "path_image": "http://res.cloudinary.com/dsiamqhuu/image/upload/v1751581488/ICHEJA/ICHEJA/T2_R1_3.svg"},
          {"vocal": "D", "path_image": "http://res.cloudinary.com/dsiamqhuu/image/upload/v1751581517/ICHEJA/ICHEJA/T2_R1_5.svg"},
        ]
      }
    };

    return MemoramaExerciseModel.fromJson(mockData);
  }

  void _initializeCards() {
    if (_currentExercise == null) return;

    _cards.clear();
    _selectedCards.clear();
    _matchedPairs = 0;
    _gameCompleted = false;
    _canSelect = true;

    int cardId = 0;
    
    // Crear cartas de letras y señas
    for (final item in _currentExercise!.items) {
      // Carta con letra
      _cards.add(MemoramaCard(
        id: cardId++,
        content: item.letter,
        type: MemoramaCardType.letter,
        pairId: item.letter,
      ));

      // Carta con seña
      _cards.add(MemoramaCard(
        id: cardId++,
        content: item.imageUrl,
        type: MemoramaCardType.image,
        pairId: item.letter,
      ));
    }

    // Mezclar las cartas
    _cards.shuffle(Random());
    notifyListeners();
  }

  void selectCard(int cardIndex) {
    if (!_canSelect || 
        _cards[cardIndex].isFlipped || 
        _cards[cardIndex].isMatched ||
        _selectedCards.length >= 2) {
      return;
    }

    _cards[cardIndex].isFlipped = true;
    _selectedCards.add(cardIndex);

    if (_selectedCards.length == 2) {
      _canSelect = false;
      _checkMatch();
    }

    notifyListeners();
  }

  void _checkMatch() {
    Timer(const Duration(milliseconds: 1000), () {
      final firstCard = _cards[_selectedCards[0]];
      final secondCard = _cards[_selectedCards[1]];

      if (firstCard.pairId == secondCard.pairId) {
        // ¡Coincidencia!
        firstCard.isMatched = true;
        secondCard.isMatched = true;
        _matchedPairs++;

        if (_matchedPairs == _currentExercise!.items.length) {
          _gameCompleted = true;
        }
      } else {
        // No coinciden, voltear de nuevo
        firstCard.isFlipped = false;
        secondCard.isFlipped = false;
      }

      _selectedCards.clear();
      _canSelect = true;
      notifyListeners();
    });
  }

  void resetGame() {
    _initializeCards();
  }

  Future<void> speak(String text) async {
    await speakUseCase(text);
  }

  Future<void> stop() async {
    await stopUseCase();
  }

  @override
  void dispose() {
    stop();
    _isSpeakingSubscription.cancel();
    super.dispose();
  }
}