import 'package:flutter/services.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((taskName, inputData) async {
//     ScheduledNotificationHelper().schedulePrayNotification(inputData.);
//     return Future.value(true);
//   } );
// }

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  if (StorageRepository.getString(Keys.lang) == '') {
    await StorageRepository.putString(Keys.lang, 'uz');
  }
  // await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(EasyLocalization(
      saveLocale: true,
      startLocale: const Locale('uz'),
      supportedLocales: const [Locale("uz"), Locale("ru")],
      path: "lib/core/lang",
      child: const App()));

  // portraitUp (vertikal) rejimida bo'lishi uchun
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // StatusBar Temasi
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
