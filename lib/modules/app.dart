import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? const IosApp() : const AndroidApp();
  }
}

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.system,
      dark: AppTheme().darkMode,
      light: AppTheme().lightMode,
      builder: (ThemeData theme, ThemeData dark) {
        return ScreenUtilInit(
          designSize: kIsWeb ? const Size(1440, 1024) : const Size(375, 812),
          builder: (context, child) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => GeolocationCubit()),
              BlocProvider(create: (context) => NamozTimeBloc()),
              BlocProvider(create: (context) => QuronBloc()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: AppTheme().darkMode,
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

class IosApp extends StatelessWidget {
  const IosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAdaptiveTheme(
        initial: AdaptiveThemeMode.system,
        dark: AppTheme().cupertinoDarkMode,
        light: AppTheme().cupertinoLightMode,
        builder: (CupertinoThemeData theme) {
          return ScreenUtilInit(
              designSize:
                  kIsWeb ? const Size(1440, 1024) : const Size(375, 812),
              builder: (context, child) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => GeolocationCubit()),
                      BlocProvider(create: (context) => NamozTimeBloc()),
                      BlocProvider(create: (context) => QuronBloc()),
                    ],
                    child: CupertinoApp(
                      debugShowCheckedModeBanner: false,
                      navigatorKey: navigatorKey,
                      initialRoute: '/',
                      theme: theme,
                      localizationsDelegates: context.localizationDelegates,
                      supportedLocales: context.supportedLocales,
                      locale: context.locale,
                      onGenerateRoute: RouteList.router.onGenerate,
                    ),
                  ));
        });
  }
}
