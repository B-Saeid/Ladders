import 'dart:math';

import 'package:flutter/material.dart';

import '../Styles/app_colors.dart';
import 'riverpod_helper_widgets.dart';

class MyHandle extends StatelessWidget {
  final Color? color;
  final double? width;
  final bool outlined;
  final Color? borderColor;
  final double? borderWidth;

  const MyHandle({
    super.key,
    this.color,
    this.width,
    this.outlined = false,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final width = this.width ?? 28;

    return outlined
        ? Stack(
            alignment: Alignment.center,
            children: [
              handle(width, opaque: true),
              outlinedHandle(width),
            ],
          )
        : handle(width);
  }

  Widget handle(double width, {bool opaque = false}) => ClipPath(
        clipper: _MyHandleClipper(),
        child: Opacity(
          opacity: opaque ? 0 : 1,
          child: SizedBox(
            width: width,
            child: AspectRatio(
              aspectRatio: 6 / 10,
              child: ColoredBox(
                color: color ?? AppColors.lightPrimary,
              ),
            ),
          ),
        ),
      );

  RefWidget outlinedHandle(double width) => RefWidget(
        (ref) {
          final borderWidth = this.borderWidth ?? 1;
          return SizedBox(
            /// This is JUST what is needed to be subtracted from the width
            /// Although the border is drawn on both sides,
            /// Only one side that touches the end so to avoid cutting the handle
            /// It is sufficient to subtract borderWidth only not 2 * borderWidth.
            width: width - borderWidth,
            child: AspectRatio(
              aspectRatio: 6 / 10,
              child: CustomPaint(
                painter: _MyHandleBorderPainter(
                  width: borderWidth,
                  color: borderColor ?? AppColors.whileDarkLightBlack(ref),
                ),
              ),
            ),
          );
        },
      );
}

class _MyHandleClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) => getPath(size);

  Path getPath(Size size, {bool forPaint = false}) {
    final path = Path();

    /// Creating an outline graph
    double x(double number) => size.width * (number / 6);
    double y(double number) => size.height * (number / 10);

    /// Now we have a grid of 6 by 10 grid,
    /// You can imagine that you have a pen that can draw on the grid
    path.moveTo(x(3), y(0));

    if (forPaint) {
      path.moveTo(x(0.5), y(5));
    } else {
      path.lineTo(x(3), y(5));
      path.lineTo(x(0.5), y(5));
    }

    /// Note: The path auto complete itself with a line to (5,0)
    /// however we need to add a small arc to complete the shape.
    path.arcToPoint(Offset(x(3), y(0)), radius: Radius.circular(x(8)), clockwise: false);

    /// Copying what we have so far with a rotation of 180 degrees on the y axis
    /// and an offset of 10 on the x axis.
    path.addPath(
      path,
      Offset(x(6), y(0)),
      matrix4: Matrix4.rotationY(pi).storage,
    );

    /// Now we cre the second half of the shape the bulky drop which will be used
    /// as the handle and It is an large arc starting from (2.5,5) to (7.5,5) counterclockwise
    final path2 = Path();
    path2.moveTo(x(0.5), y(5));
    // path2.addOval(
    //   Rect.fromCircle(
    //     center: Offset(x(5), y(5)),
    //     radius: x(5),
    //   ),
    // );
    path2.arcToPoint(
      Offset(x(5.5), y(5)),
      radius: Radius.circular(x(3)),
      clockwise: false,
      largeArc: true,
    );

    /// Now we add the two parts of the shape together.
    path.addPath(path2, Offset.zero);
    return path;
  }
}

class _MyHandleBorderPainter extends CustomPainter {
  final double width;
  final Color color;

  _MyHandleBorderPainter({this.width = 1.0, this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    final path = _MyHandleClipper().getPath(size, forPaint: true);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = width;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
