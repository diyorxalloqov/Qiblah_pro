import 'package:qiblah_pro/modules/auth/bloc/auth_bloc.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? const IosApp() : const AndroidApp();
  }
}

class AndroidApp extends StatefulWidget {
  const AndroidApp({super.key});

  @override
  State<AndroidApp> createState() => _AndroidAppState();
}

class _AndroidAppState extends State<AndroidApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // Handle app resumed state
        break;
      case AppLifecycleState.inactive:
        // Handle app inactive state
        break;
      case AppLifecycleState.paused:
        // Handle app paused state
        break;
      case AppLifecycleState.detached:
        // Handle app detached state
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              BlocProvider(create: (context) => AuthBloc()),
              BlocProvider(create: (context) => ZikrBloc()),
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

class IosApp extends StatefulWidget {
  const IosApp({super.key});

  @override
  State<IosApp> createState() => _IosAppState();
}

class _IosAppState extends State<IosApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // Handle app resumed state
        break;
      case AppLifecycleState.inactive:
        // Handle app inactive state
        break;
      case AppLifecycleState.paused:
        // Handle app paused state
        break;
      case AppLifecycleState.detached:
        // Handle app detached state
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                      BlocProvider(create: (context) => AuthBloc()),
                      BlocProvider(create: (context) => ZikrBloc()),
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
