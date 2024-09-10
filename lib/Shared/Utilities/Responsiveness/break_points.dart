abstract class BreakPoints {
  ///   https://www.browserstack.com/guide/responsive-design-breakpoints
  /// What is a Breakpoint in Responsive Design?
  // A breakpoint in responsive design refers to specific screen
  // widths or device dimensions at which the layout of a website or
  // web application changes to provide an optimal viewing experience.

  // static const double mobile = 480;
  static const double mobile = 768;
  // static const double tablet = 1024;

  static bool isMobile(double width) => width <= mobile;

  // static bool isTablet(double width) => width <= tablet;
// static const double desktop = 1280;
}
