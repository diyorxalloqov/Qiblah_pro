import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

extension ThemesData on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  bool get isLight => Theme.of(this).brightness == Brightness.light;
}

    // SchedulerBinding.instance.platformDispatcher.platformBrightness;
    // var brightness = View.of(context).platformDispatcher.platformBrightness;
