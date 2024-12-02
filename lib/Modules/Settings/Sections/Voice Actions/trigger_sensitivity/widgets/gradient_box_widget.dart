part of '../tile.dart';

class _GradientBoxWidget extends ConsumerWidget {
  final double height;
  final double width;

  const _GradientBoxWidget({
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentage = ref.watch(amplitudePercentageProvider);
    print('Percentage is GRADIENT BOX $percentage');
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          _bottomContainer(percentage, ref),
          _topLiveContainer(context, ref, percentage),
        ],
      ),
    );
  }

  ClipPath _topLiveContainer(BuildContext context, WidgetRef ref, double? percentage) => ClipPath(
        clipper: _MyClipper(
          percentage: _isOK(percentage) ? percentage! : 0,
          isRTL: Directionality.of(context).isRTL,
        ),
        child: Container(
          decoration: ShapeDecoration(
            color: _isNegative(percentage) ? Colors.green : null,
            gradient: _isOK(percentage) ? _gradient(true) : null,
            shape: RoundedRectangleBorder(
              side: _borderSide(percentage, ref),
              borderRadius: BorderRadiusDirectional.circular(height / 5),
            ),
          ),
        ),
      );

  AnimatedContainer _bottomContainer(double? percentage, WidgetRef ref) => AnimatedContainer(
        duration: 300.milliseconds,
        curve: Curves.decelerate,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: _borderSide(percentage, ref),
            borderRadius: BorderRadiusDirectional.circular(height / 5),
          ),
          gradient: _isOK(percentage) ? _gradient(false) : _disabledGradient,
        ),
      );

  BorderSide _borderSide(double? percentage, WidgetRef ref) => BorderSide(
        color: percentage != null
            ? AppColors.whileDarkLightBlack(ref)
            : LiveData.themeData(ref).disabledColor,
      );

  bool _isOK(double? percentage) => percentage != null && !percentage.isNegative;

  bool _isNegative(double? percentage) => percentage != null && percentage.isNegative;

  LinearGradient _gradient(bool bright) => LinearGradient(
        colors: bright ? SensitivityConstants._colorsList : SensitivityConstants._fadedColorsList,
        stops: SensitivityConstants._accumulatedPercentageList,
        begin: AlignmentDirectional.centerStart,
        end: AlignmentDirectional.centerEnd,
      );

  LinearGradient get _disabledGradient =>  LinearGradient(
        colors: [Colors.grey.shade400, Colors.grey],
        begin: AlignmentDirectional.centerStart,
        end: AlignmentDirectional.centerEnd,
      );
}

class _MyClipper extends CustomClipper<Path> {
  final double percentage;
  final bool isRTL;

  _MyClipper({required this.percentage, required this.isRTL});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (isRTL) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width - percentage * size.width, 0);
      path.lineTo(size.width - percentage * size.width, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.lineTo(percentage * size.width, 0);
      path.lineTo(percentage * size.width, size.height);
      path.lineTo(0, size.height);
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
// bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
