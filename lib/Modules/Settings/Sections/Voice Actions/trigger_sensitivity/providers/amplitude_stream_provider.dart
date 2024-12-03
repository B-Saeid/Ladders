part of '../tile.dart';

/// Amplitude is ranging from -160 to 0 as per the [record] plugin implementation
final amplitudeStreamProvider = StreamProvider.autoDispose<double?>(
  (ref) {
    final recorder = AudioRecorder();
    final controller = StreamController<double?>();

    final enabled = ref.watch(
      settingProvider.select((p) => p.enableVoiceActions || p.restOnlyTrigger),
    );
    print('Enabled in amplitude stream provider $enabled');

    /// This is to ensure we listen to the correct input device
    if (enabled) {
      print('Calling updateInputDevices from amplitude stream provider');
      ref.read(settingProvider).updateInputDevices();
    }

    final inputDevice = ref.watch(settingProvider.select((p) => p.microphone?.inputDevice));
    print('inputDevice in amplitude stream provider $inputDevice');

    /// This is to detect whether amplitude is not dead
    final lastAmpReads = <double>[];
    final interval = 50.milliseconds;

    bool checkForDeadStream(Amplitude event) {
      final current = event.current.abs();

      final listLength = 1.seconds.inMilliseconds ~/ interval.inMilliseconds;
      if (lastAmpReads.length < listLength) {
        lastAmpReads.add(current);
        return false;
      } else if (lastAmpReads.toSet().length == 1 && lastAmpReads.sum != 0) {
        print('----------------- Amplitude is dead');
        return true;
      } else {
        lastAmpReads.clear();
        return false;
      }
    }

    Future<void> monitorMic() async {
      print('Called Monitoring Mic');
      if (!enabled || inputDevice == null) return controller.sink.add(null);
      print('Monitoring Mic');

      await recorder.startStream(
        RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          device: inputDevice,
        ),
      );

      await for (final value in recorder.onAmplitudeChanged(interval)) {
        // print('Listening ..... ${value.current.abs()}');
        final dead = checkForDeadStream(value);
        if (dead) {
          ref.invalidateSelf();
          break;
        }

        controller.sink.add(value.current);
      }
    }

    controller.onListen = () {
      print('---------- controller.onListen -----');

      /// That was wrongly obscuring the loading state.
      ///
      /// As far as I experienced the loading state is the state starting
      /// when the stream is listened to  and yet the stream first event is not ready.
      // controller.sink.add(-1);
      monitorMic();
    };

    ref.onDispose(
      () async {
        print('---------- onDispose');
        await recorder.dispose();
        controller.close();
      },
    );

    return controller.stream;
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
