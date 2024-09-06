import 'dart:async';
import 'dart:developer' as devtools show log;
import 'dart:isolate';

import 'package:flutter/material.dart';

import 'isolates_service.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

class ParallelismTestingUI extends StatefulWidget {
  const ParallelismTestingUI({super.key});

  @override
  State<ParallelismTestingUI> createState() => _ParallelismTestingUIState();
}

class _ParallelismTestingUIState extends State<ParallelismTestingUI> {
  StreamController<String> bigIntPeriodicStreamController = StreamController.broadcast();
  Timer? mainTimer;

  Stream<String> startFactorialOnMainIsolate() {
    mainTimer ??= Timer.periodic(const Duration(microseconds: 1000), (timer) {
      try {
        bigIntPeriodicStreamController.add(IsolatesService.factorial(timer.tick).toString());
      } on StackOverflowError {
        bigIntPeriodicStreamController.add('Stack Over Flow !! ON MAIN ISOLATE 🤓');
        cancelMainIsolateTimer();
      } catch (e) {
        bigIntPeriodicStreamController.add('Some thing went ron !! 🧐 ON MAIN ISOLATE');
        cancelMainIsolateTimer();
      }
    });
    // final bigIntPeriodicStream = Stream<String>.periodic(
    //   const Duration(microseconds: 500),
    //   (computationCount) => IsolateSpawner.factorial(computationCount).toString(),
    // );
    // return bigIntPeriodicStream.asBroadcastStream();
    return bigIntPeriodicStreamController.stream;
  }

  void cancelMainIsolateTimer() {
    mainTimer?.cancel();
    mainTimer = null;
    // SchedulerBinding.instance.scheduleTask(() => null, priority)
    // compute((message) => null, message)
    Isolate.run(() => null);
  }

  var isOnSeparateIsolate = false;

  Stream<String>? anotherIsolateStreamOfStrings;
  Stream<String>? mainIsolateStreamOfStrings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LinearProgressIndicator(),
        leading: const CircularProgressIndicator(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton(
                onPressed: () => setState(() => cancelMainIsolateTimer()),
                child: const Text('Cancel Main Timer'),
              ),
              FilledButton(
                onPressed: () {
                  final stream = startFactorialOnMainIsolate();
                  setState(() => mainIsolateStreamOfStrings = stream);
                },
                child: const Text('Start Factorial On Main Isolate'),
              ),
              SwitchListTile(
                title: const Text('Show Separate Isolate'),
                value: isOnSeparateIsolate,
                onChanged: (value) => setState(() => isOnSeparateIsolate = value),
              ),
              FilledButton(
                onPressed: () async {
                  final stream = await IsolatesService.startFactorialOnAnotherIsolate();
                  setState(() => anotherIsolateStreamOfStrings = stream);
                },
                child: const Text('Spawn - if not yet - and Start A separate Isolate'),
              ),
              FilledButton(
                onPressed: () => setState(() => IsolatesService.cancelTheOtherIsolateAndTimer()),
                child: const Text('Cancel The isolate And its Timer'),
              ),
              StreamBuilder(
                stream: isOnSeparateIsolate ? anotherIsolateStreamOfStrings : mainIsolateStreamOfStrings,
                builder: (context, snapshot) => Column(
                  children: [
                    Chip(label: Text('${IsolatesService.getCurrentIsolate()}')),
                    Text(snapshot.data.toString().length.toString(), maxLines: null),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
