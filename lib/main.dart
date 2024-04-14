import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qiblah_pro/core/constants/keys.dart';
import 'package:qiblah_pro/core/db/shared_preferences.dart';
import 'package:qiblah_pro/core/singletons/service_locator.dart';
import 'package:qiblah_pro/modules/app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await setupLocator();
  await MobileAds.instance.initialize();

  StorageRepository.getString(Keys.lang) == ''
      ? await StorageRepository.putString(Keys.lang, 'uz')
      : null;
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
