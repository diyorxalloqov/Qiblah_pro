import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

extension ThemesData on BuildContext {
  bool get isDark => Platform.isIOS
      ? CupertinoTheme.of(this).brightness == Brightness.dark
      : Theme.of(this).brightness == Brightness.dark;
}

    // SchedulerBinding.instance.platformDispatcher.platformBrightness;
    // var brightness = View.of(context).platformDispatcher.platformBrightness;
