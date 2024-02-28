import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qiblah_pro/core/constants/keys.dart';
import 'package:qiblah_pro/core/db/shared_preferences.dart';
import 'package:qiblah_pro/core/singletons/service_locator.dart';
import 'package:qiblah_pro/modules/app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NamesDbService().clearDatabase();
  // await QuronDBService().clearDatabases();
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

  // portraitUp (vertikal) rejimida bo'lishi uchun
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // StatusBar Temasi
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

 

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LayoutBuilderExample(),
//     );
//   }
// }

// class LayoutBuilderExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Layout Builder Example'),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Center(
//             child: Container(
//               color: Colors.blue,
//               height: constraints.maxHeight * 0.5,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Max Width: ${constraints.maxWidth.toStringAsFixed(2)}',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Max Height: ${constraints.maxHeight.toStringAsFixed(2)}',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
