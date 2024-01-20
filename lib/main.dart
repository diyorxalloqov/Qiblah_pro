import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qiblah_pro/modules/app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      saveLocale: true,

      startLocale: const Locale("uz"),
      supportedLocales: const [Locale("uz"), Locale("ru")],
      path: "lib/core/lang",
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
