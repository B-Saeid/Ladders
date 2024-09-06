// import 'package:flutter/material.dart';
//
// typedef CloseLoadingScreen = bool Function();
// typedef UpdateLoadingScreen = bool Function(String text);
//
// @immutable
// class LoadingScreenController {
//   final CloseLoadingScreen close;
//   final UpdateLoadingScreen update;
//
//   const LoadingScreenController({
//     required this.close,
//     required this.update,
//   });
// }
//
// class LoadingScreen {
//   factory LoadingScreen() => _shared;
//   static final LoadingScreen _shared = LoadingScreen._sharedInstance();
//
//   LoadingScreen._sharedInstance();
//
//   LoadingScreenController? controller;
//
//   void show({
//     required BuildContext context,
//     // required String text,
//   }) {
//     // if (controller?.update(text) ?? false) {
//     //   return;
//     // } else {
//     controller = showOverlay(
//       context: context,
//       // text: text,
//     );
//     // }
//   }
//
//   void hide() {
//     controller?.close();
//     controller = null;
//   }
//
//   LoadingScreenController showOverlay({
//     required BuildContext context,
//     // required String text,
//   }) {
//     // final textStreamController = StreamController<String>();
//     // textStreamController.add(text);
//
//     final state = Overlay.of(context);
//     final renderBox = context.findRenderObject() as RenderBox;
//     final size = renderBox.size;
//
//     final overlay = OverlayEntry(
//       builder: (context) {
//         return Container(
//           color: Colors.black.withOpacity(0.9),
//           width: size.width,
//           height: size.height,
//           // child: Center(
//           //   child: Container(
//           //       constraints: BoxConstraints(
//           //         maxWidth: size.width * 0.8,
//           //         maxHeight: size.height * 0.8,
//           //         minWidth: size.width * 0.5,
//           //       ),
//           //       decoration: BoxDecoration(
//           //         color: Colors.white,
//           //         borderRadius: BorderRadius.circular(10.0),
//           //       ),
//           //       child: const Padding(
//           //         padding: EdgeInsets.all(16.0),
//           //         child: SingleChildScrollView(
//           //           child: Column(
//           //             mainAxisSize: MainAxisSize.min,
//           //             mainAxisAlignment: MainAxisAlignment.center,
//           //             children: [
//           //               SizedBox(height: 10),
//           //               CircularProgressIndicator(),
//           //               SizedBox(height: 20),
//           //               // StreamBuilder(
//           //               //   stream: textStreamController.stream,
//           //               //   builder: (context, snapshot) {
//           //               //     if (snapshot.hasData) {
//           //               //       return Text(
//           //               //         snapshot.data as String,
//           //               //         textAlign: TextAlign.center,
//           //               //       );
//           //               //     } else {
//           //               //       return Container();
//           //               //     }
//           //               //   },
//           //               // ),
//           //             ],
//           //           ),
//           //         ),
//           //       )),
//           // ),
//           child: const SizedBox(),
//         );
//       },
//     );
//
//     state.insert(overlay);
//
//     return LoadingScreenController(
//       close: () {
//         // textStreamController.close();
//         overlay.remove();
//         return true;
//       },
//       update: (text) {
//         // textStreamController.add(text);
//         return true;
//       },
//     );
//   }
// }
