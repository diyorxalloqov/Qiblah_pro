import 'package:qiblah_pro/core/router/app_routes.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? ScreenUtilInit(
            // designSize: kIsWeb ? Size(1920, 1080) : Size(375, 667),
            designSize: kIsWeb ? const Size(1440, 1024) : const Size(412, 892),
            builder: (context, child) => CupertinoApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              initialRoute: '/',
              onGenerateRoute: RouteList.router.onGenerate,
            ),
          )
        : ScreenUtilInit(
            designSize: kIsWeb ? const Size(1440, 1024) : const Size(412, 892),
            builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              initialRoute: '/',
              onGenerateRoute: RouteList.router.onGenerate,
            ),
          );
  }
}
