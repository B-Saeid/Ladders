part of '../tile.dart';

/// Amplitude is ranging from -160 to 0 as per the [record] plugin implementation
final amplitudeStreamProvider = StreamProvider.autoDispose<double?>(
  (ref) {
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

    AudioRecorder? recorder;

    Future<void> disposeMic([bool exit = false]) async {
      await recorder?.dispose();
      recorder = null;

      if (!exit) /*Future(() =>*/ controller.sink.add(null) /*)*/;
    }

    /// This is to detect whether amplitude is not dead
    // static bool _liveMic = false;
    final lastAmpReads = <double>[];

    Future<void> checkForDeadStream(Amplitude event) async {
      final current = event.current.abs().toStringAsFixed(5);

      if (lastAmpReads.length < 20) {
        // print('Added to list');
        lastAmpReads.add(double.parse(current));
      } else if (lastAmpReads.toSet().length == 1 && lastAmpReads.sum != 0) {
        print('----------------- Amplitude is dead');
        await disposeMic();
      } else {
        lastAmpReads.clear();
        // print('-- List cleared');
      }
    }

    var canCall = true;

    Future<void> monitorMic() async {
      print('Called Monitoring Mic');
      if (!canCall || !enabled) return;
      canCall = false;
      print('Monitoring Mic');

      await disposeMic();

      if (inputDevice == null) return;

      recorder = AudioRecorder();
      await recorder!.startStream(
        RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          device: inputDevice,
        ),
      );

      await for (final value in recorder!.onAmplitudeChanged(50.milliseconds)) {
        // print('Listening ..... ${value.current.abs()}');
        controller.sink.add(value.current);
        await checkForDeadStream(value);
      }
      canCall = false;
    }

    controller.onListen = () {
      print('---------- controller.onListen -----');
      controller.sink.add(null);
      monitorMic();
    };
    ref.onAddListener(
      () {
        // print('---------- onAddListener');
        // monitorMic(inputDevice);
      },
    );
    ref.onCancel(
      () {
        // print('---------- onCancel');
      },
    );
    ref.onResume(
      () {
        // print('---------- onResume');
      },
    );
    ref.onRemoveListener(
      () {
        // print('---------- onRemoveListener');
      },
    );

    ref.onDispose(
      () {
        print('---------- onDispose');
        disposeMic(true);
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
      // loading: () => -1,
      loading: () => null,
    );
  },
);
