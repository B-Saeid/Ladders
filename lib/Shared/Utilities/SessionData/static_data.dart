part of 'session_data.dart';

abstract class StaticData {
  static double get scalePercentage => LiveData.__scalePercentage;

  static MediaQueryData get mediaQuery => LiveData.__mediaQuery;

  static Size get sizeQuery => LiveData.__sizeQuery;

  static double get deviceWidth => LiveData.__deviceWidth;

  static double get deviceHeight => LiveData.__deviceHeight;

  static EdgeInsets get viewPadding => LiveData.__viewPadding;

  static EdgeInsets get viewInsets => LiveData.__viewInsets;

  static EdgeInsets get padding => LiveData.__padding;

  static bool get isPortrait => LiveData.__isPortrait;

  static ThemeData get themeData => LiveData.__themeData;

  static TextTheme get textTheme => LiveData.__textTheme;

  static bool get isLight => LiveData.__isLight;
}
