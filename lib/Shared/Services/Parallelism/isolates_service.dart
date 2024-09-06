import 'dart:async';
import 'dart:isolate';

abstract class IsolatesService {
  static BigInt factorial(int number) =>
      number > 2 ? BigInt.from(number) * factorial(number - 1) : BigInt.from(number);

  static final StreamController<String> _bigIntPeriodicStreamController = StreamController();
  static Timer? _anotherTimer;

  static Future<void> _startFactorialOnAnotherIsolate(SendPort sendPort) async {
    _anotherTimer ??= Timer.periodic(const Duration(microseconds: 1000), (timer) {
      try {
        _bigIntPeriodicStreamController.add(factorial(timer.tick).toString());
      } on StackOverflowError {
        _bigIntPeriodicStreamController.add('Stack Over Flow !! 🤓 ON WORKER ISOLATE');
        cancelTheOtherIsolateAndTimer();
      } catch (e) {
        _bigIntPeriodicStreamController.add('Some thing went ron !! 🧐 ON WORKER ISOLATE');
        cancelTheOtherIsolateAndTimer();
      }
    });

    // _bigIntPeriodicStreamController.onListen ??= () {
    // _bigIntPeriodicStreamController.add(/*the latest emitted value*/);
    // };
    // final bigIntPeriodicStream = Stream<BigInt>.periodic(
    //   const Duration(microseconds: 500),
    //   (computationCount) => factorial(computationCount),
    // );
    await for (final bigIntString in _bigIntPeriodicStreamController.stream) {
      sendPort.send(bigIntString);
      //   if (bigInt.isValidInt) {
      //     sendPort.send(bigInt);
      //   } else {
      //     Isolate.exit(sendPort, 'Memory Limit Reached ... Exiting The factorialIsolate');
      //   }
    }
  }

  static void cancelTheOtherIsolateAndTimer() {
    _anotherTimer?.cancel();
    _anotherTimer = null;
    // Isolate.exit(_isolate?.controlPort); // NOT IN THE SAME GROUP AS MAIN !!!!!!?
    _isolate?.kill();
    _isolate = null;
  }

  static Isolate? _isolate;

  static Future<Stream<String>> startFactorialOnAnotherIsolate() async {
    final receivePort = ReceivePort();
    _isolate ??= await Isolate.spawn(
      _startFactorialOnAnotherIsolate,
      receivePort.sendPort,
      debugName: 'factorialSeparateIsolate',
    );
    return receivePort.takeWhile((element) => element is String).asBroadcastStream().cast();
  }

  static String? getCurrentIsolate() {
    return Isolate.current.debugName;
  }
}
