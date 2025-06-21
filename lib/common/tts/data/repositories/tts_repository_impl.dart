import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:icheja_mobile/common/tts/domain/repositories/tts_repository.dart';

class TtsRepositoryImpl implements TtsRepository {
  final FlutterTts _flutterTts;
  final _isSpeakingController = StreamController<bool>.broadcast();

  TtsRepositoryImpl(this._flutterTts) {
    _flutterTts.setStartHandler(() {
      _isSpeakingController.add(true);
    });

    _flutterTts.setCompletionHandler(() {
      _isSpeakingController.add(false);
    });

    _flutterTts.setErrorHandler((msg) {
      _isSpeakingController.add(false);
    });

    _flutterTts.setCancelHandler(() {
      _isSpeakingController.add(false);
    });
  }

  @override
  Stream<bool> get isSpeakingStream => _isSpeakingController.stream;

  @override
  Future<void> speak(String text) async {
    await stop();

    await _flutterTts.setLanguage("es-MX");

    try {
      List<dynamic> voices = await _flutterTts.getVoices;
      var mexicanVoice = voices.firstWhere(
        (voice) => voice['locale'] == 'es-MX',
        orElse: () => null,
      );
      if (mexicanVoice != null) {
        await _flutterTts.setVoice(
            {"name": mexicanVoice['name'], "locale": mexicanVoice['locale']});
      }
    } catch (e) {
      print("Error finding voice: $e");
    }

    await _flutterTts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _flutterTts.stop();
  }

  @override
  void dispose() {
    _isSpeakingController.close();
  }
}
