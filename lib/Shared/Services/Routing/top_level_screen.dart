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

class MyClipper extends CustomClipper<Path> {
  // @override
  // Path getClip(Size size) {
  //   final path = Path();
  //   print(path.getBounds());
  //   // path.moveTo(size.width/2, 0);
  //   // path.moveTo(size.width/2, size.width/2);
  //   // path.moveTo(0, size.width/2);
  //   // print(path.getBounds());
  //   path.lineTo(size.width / 2, 0);
  //   path.lineTo(size.width / 2, size.width *(3/ 4));
  //   path.arcToPoint(
  //     Offset(size.width / 4, size.width),
  //     radius: Radius.circular(size.width / 4),
  //     // clockwise: false,
  //   );
  //   // path.arcTo(
  //   //   /// Imagine you draw a circle with a radius of size.width/4
  //   //   /// and then you only want the arc of the circle from 0 to 1/2 * pi
  //   //   Rect.fromCircle(center: Offset(size.width / 4, 3/4 *size.width), radius: size.width / 4),
  //   //   0,
  //   //   1/2 * pi,
  //   //   false,
  //   // );
  //   path.lineTo(0, size.width);
  //   print(path.getBounds());
  //   // path.lineTo(size.width/2, 0);
  //   // path.arcTo(Rect.fromLTRB(left, top, right, bottom));
  //   // path.lineTo(size.width, size.height);
  //   // path.lineTo(size.width, 0);
  //   // path.close();
  //   return path;
  // }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

  @override
  Path getClip(Size size) {
    final path = Path();

    /// Creating an outline graph
    double x(double number) => size.width * (number / 10);
    double y(double number) => size.height * (number / 10);

    /// Now we have a grid of 10 by 10 grid,
    /// You can imagine that you have a pen that can draw on the grid
    path.moveTo(x(5), y(0));

    path.lineTo(x(5), y(5));
    path.lineTo(x(2.5), y(5));

    /// Note: The path auto complete itself with a line to (5,0)
    /// however we need to add a small arc to complete the shape.
    path.arcToPoint(Offset(x(5), y(0)), radius: Radius.circular(x(12)), clockwise: false);

    /// Copying what we have so far with a rotation of 180 degrees on the y axis
    /// and an offset of 10 on the x axis.
    path.addPath(
      path,
      Offset(x(10), y(0)),
      matrix4: Matrix4.rotationY(pi).storage,
    );

    /// Now we cre the second half of the shape the bulky drop which will be used
    /// as the handle and It is an large arc starting from (2.5,5) to (7.5,5) counterclockwise
    final path2 = Path();
    path2.moveTo(x(2.5), y(5));
    path2.arcToPoint(
      Offset(x(7.5), y(5)),
      radius: Radius.circular(x(3)),
      clockwise: false,
      largeArc: true,
    );

    /// Now we add the two parts of the shape together.
    path.addPath(path2, Offset.zero);
    return path;
    // path.arcToPoint(
    //   Offset(x(5), y(0)),
    //   radius: Radius.circular(x(12)),
    // );
    // path.arcToPoint(
    //   Offset(x(5), y(0)),
    //   radius: Radius.circular(x(5)),
    //   clockwise: false,
    // );
    // path.arcToPoint(
    //   Offset(x(2.5), y(5)),
    //   radius: Radius.circular(x(5)),
    // );
  }
}

class TEST2 extends StatelessWidget {
  const TEST2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: MyClipper(),
          child: Container(
            width: StaticData.deviceWidth,
            height: StaticData.deviceWidth,
            color: AppColors.lightPrimary,
          ),
        ),
      ),
    );
  }
}
