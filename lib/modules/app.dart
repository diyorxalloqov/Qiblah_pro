import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:qiblah_pro/core/router/app_routes.dart';
import 'package:qiblah_pro/core/theme/app_theme.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/onBoarding/bloc/on_boarding_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? ScreenUtilInit(
            designSize: kIsWeb ? const Size(1440, 1024) : const Size(412, 892),
            builder: (context, child) => BlocProvider(
                  create: (context) => OnBoardingBloc(),
                  child: CupertinoApp(
                    debugShowCheckedModeBanner: false,
                    navigatorKey: navigatorKey,
                    initialRoute: '/',
                    theme: AppTheme().cupertinoLightMode,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    builder: (context, child) {
                      return CupertinoTheme(
                        data: AppTheme().cupertinoDarkMode,
                        child: child!,
                      );
                    },
                    onGenerateRoute: RouteList.router.onGenerate,
                  ),
                ))
        : AdaptiveTheme(
            initial: AdaptiveThemeMode.system,
            dark: AppTheme().darkMode,
            light: AppTheme().lightMode,
            builder: (theme, dark) {
              return ScreenUtilInit(
                designSize:
                    kIsWeb ? const Size(1440, 1024) : const Size(412, 892),
                builder: (context, child) => BlocProvider(
                  create: (context) => OnBoardingBloc(),
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    theme: theme,
                    themeMode: ThemeMode.system,
                    navigatorKey: navigatorKey,
                    initialRoute: '/',
                    onGenerateRoute: RouteList.router.onGenerate,
                  ),
                ),
              );
            },
          );
  }
}
