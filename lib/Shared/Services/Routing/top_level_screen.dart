part of 'routes_base.dart';

class TopLevelScreen extends ConsumerWidget {
  const TopLevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// TODO : Add the animation of app logo spinning
    return const Scaffold();
  }

// Widget build(BuildContext context) {
//   return Scaffold(
//     // appBar: AppBar(title: Text(AppLocalizations.of(context).helloWorld)),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Localizations.override(
//             context: context,
//             // Using a Builder to get the correct BuildContext.
//             // Alternatively, you can create a new widget and Localizations.override
//             // will pass the updated BuildContext to the new widget.
//             child: Builder(
//               builder: (context) {
//                 // A toy example for an internationalized Material widget.
//                 return CalendarDatePicker(
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime(2100),
//                   onDateChanged: (value) {},
//                 );
//               },
//             ),
//           ),
//           // ElevatedButton(
//           //     onPressed: () async {
//           //       /// Works on android ..
//           //       /// needs Deeps links set on ios to work
//           //       final beep = await Restart.restartApp();
//           //       print('Restart APP : $beep');
//           //       // await SystemNavigator.pop();
//           //       // await 4.seconds.delay;
//           //       // await UrlLauncher.httpsLink(
//           //       //   'https://oncourse-9beec.web.app/authAction',
//           //       // );
//           //     },
//           //     child: const Text('Restart THe App'))
//         ],
//       ),
//     ),
//   );
// }
}
