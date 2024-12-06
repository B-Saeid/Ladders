part of '../tile.dart';

final recorderProvider = Provider<AudioRecorder>((_) => AudioRecorder());

final amplitudeStateProvider = StateProvider<double?>((_) => null);

/// Amplitude is ranging from -160 to 0 as per the [record] plugin implementation

final amplitudeStreamProvider = StreamProvider.autoDispose<double?>(
  (ref) {
    final inputDevice = ref.watch(settingProvider.select((p) => p.microphone?.inputDevice));
    print('inputDevice in amplitude stream provider $inputDevice');

    final enabled = ref.watch(
      settingProvider.select((p) => p.enableVoiceActions || p.restOnlyTrigger),
    );
    print('Enabled in amplitude stream provider $enabled');

    final restOnly = ref.watch(
      settingProvider.select((p) => p.restOnlyTrigger),
    );

    final speechRecognition = restOnly
        ? false
        : ref.watch(
            homeProvider.select((p) => p.monitoring || p.loading || p.recognizing),
          );

    if (!enabled || speechRecognition || inputDevice == null) return Stream.value(null);

    final voiceMonitoring = restOnly &&
        ref.watch(
          homeProvider.select((p) => p.monitoring),
        );

    if (voiceMonitoring) return ref.read(amplitudeStateProvider.notifier).stream;

    final recorder = ref.read(recorderProvider);
    final config = RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      device: inputDevice,
    );

    /// This is to detect whether amplitude is not dead
    final lastAmpReads = <double>[];
    final interval = 50.milliseconds;

    bool checkForDeadStream(double current) {
      final listLength = 1.seconds.inMilliseconds ~/ interval.inMilliseconds;
      if (lastAmpReads.length < listLength) {
        lastAmpReads.add(current);
        return false;
      } else if (lastAmpReads.toSet().length == 1 && lastAmpReads.sum != 0) {
        Toast.show(L10nR.tMicIsNotResponsiveRefreshing());
        print('----------------- Amplitude is dead');
        return true;
      } else {
        lastAmpReads.clear();
        return false;
      }
    }

    print('Calling updateInputDevices from amplitude stream provider');
    recorder.cancel().then(
          (_) => ref.read(settingProvider).updateInputDevices().then(
            (value) {
              if (!value) return;

              recorder.startStream(config).then(
                    (_) => ref.listenSelf(
                      (previous, next) {
                        if (next.value == null) return;
                        final dead = checkForDeadStream(next.value!);
                        if (dead) return ref.invalidateSelf();
                      },
                    ),
                  );
            },
          ),
        );

    ref.onDispose(recorder.cancel);

    final stream = recorder.onAmplitudeChanged(interval).map((amp) => amp.current);

    return stream;
  },
);

/// -1 means it is loading
/// null means error or no data yet .. For example:
/// when the settings are not enabled
final amplitudePercentageProvider = Provider.autoDispose<double?>(
  (ref) {
    final amp = ref.watch(amplitudeStreamProvider);
    return amp.when(
      data: (data) {
        if (data == null) return null;

        /// NOTE : we want our sensitivity to be ranging from
        /// [_Constants.minAmplitude] to 0 db
        /// since below [_Constants.minAmplitude] is not of interest to us in the sensitivity gauge

        final from0ToMax = max(0, data + SensitivityConstants.maxDBValue);
        return from0ToMax / SensitivityConstants.maxDBValue;
      },
      error: (error, stackTrace) {
        print('Error in Amplitude stream provider $error with $stackTrace');
        return null;
      },
      loading: () => -1,
      // loading: () => null,
    );
  },
);
