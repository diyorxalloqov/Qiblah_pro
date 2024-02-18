import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qiblah_pro/core/constants/keys.dart';
import 'package:qiblah_pro/core/db/shared_preferences.dart';
import 'package:qiblah_pro/core/singletons/service_locator.dart';
import 'package:qiblah_pro/modules/app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupLocator();
  StorageRepository.getString(Keys.lang) == ''
      ? await StorageRepository.putString(Keys.lang, 'uz')
      : null;
  EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      saveLocale: true,
      startLocale: const Locale('uz'),
      supportedLocales: const [Locale("uz"), Locale("ru")],
      path: "lib/core/lang",
      child: const App()));

  // Ilova orientatsiyasini faqat portraitUp (vertikal) rejimida bo'lishi uchun
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // StatusBar Temasi
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
