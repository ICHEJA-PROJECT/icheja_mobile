import 'dart:async';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:icheja_mobile/common/audio_player/domain/repositories/audio_player_repository.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final _isPlayingController = StreamController<bool>.broadcast();
  bool _isInitialized = false;

  @override
  Stream<bool> get isPlayingStream => _isPlayingController.stream;

  Future<void> _initialize() async {
    if (!_isInitialized) {
      await _player.openPlayer();
      _isInitialized = true;
    }
  }

  @override
  Future<void> play(String pathToAudio) async {
    await _initialize();

    _isPlayingController.add(true);
    await _player.startPlayer(
      fromURI: pathToAudio,
      whenFinished: () {
        _isPlayingController.add(false);
      },
    );
  }

  @override
  Future<void> stop() async {
    await _initialize();
    await _player.stopPlayer();
    _isPlayingController.add(false);
  }

  @override
  Future<void> dispose() async {
    if (_isInitialized) {
      await _player.closePlayer();
      _isInitialized = false;
    }
    _isPlayingController.close();
  }
}
