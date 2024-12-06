part of '../speech_service.dart';

/// TODO :Fix Bug: SFX player does not work on Android
abstract class _SfxPlayer {
  static AudioPlayer? _player;

  static Future<bool> _init() async {
    final isAndroid = StaticData.platform.isAndroid;
    if (isAndroid) return false;
    if (_player == null) {
      AudioCache.instance = AudioCache(prefix: '');
      _player = AudioPlayer();
      await _player!.setPlayerMode(PlayerMode.lowLatency);
    }
    return true;
  }

  static Future<void> dispose() async {
    await _player?.dispose();
    _player = null;
  }

  static Future<void> negative() async {
    if (!await _init()) return;
    await _player!.play(AssetSource(SoundAssets.speechStopped));
    await 0.5.seconds.delay;
  }

  static Future<void> started() async {
    if (!await _init()) return;
    await _player!.play(AssetSource(SoundAssets.speechListening));
    await 0.5.seconds.delay;
  }
}
