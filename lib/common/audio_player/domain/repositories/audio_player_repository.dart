import 'dart:async';

abstract class AudioPlayerRepository {
  Stream<bool> get isPlayingStream;
  Future<void> play(String pathToAudio);
  Future<void> stop();
  Future<void> dispose();
}
