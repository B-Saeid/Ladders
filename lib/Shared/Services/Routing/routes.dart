
enum Routes {
  home,
  account,
  settings,
  voiceActions;

  String get path => switch (this) {
        Routes.home => '/$name',
        Routes.account => '${home.path}/$name',
        Routes.settings => '${home.path}/$name',
        Routes.voiceActions => '${settings.path}/$name',
      };
}


abstract class RootRoute {
  static const String name = 'root';
  static const String path = '/';
}


