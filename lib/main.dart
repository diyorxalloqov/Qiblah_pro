import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qiblah_pro/core/singletons/service_locator.dart';
import 'package:qiblah_pro/modules/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // HiveDBService.registerAdapters();
  await setupLocator();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  runApp(EasyLocalization(
      saveLocale: true,
      startLocale: const Locale("uz"),
      supportedLocales: const [Locale("uz"), Locale("ru")],
      path: "lib/core/lang",
      child: App(pref: sharedPreferences)));
}




// import 'package:country_state_city_pro/country_state_city_pro.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController country = TextEditingController();
//   TextEditingController state = TextEditingController();
//   TextEditingController city = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Country->State->City'),
//       ),
//       body: Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               CountryStateCityPicker(
//                   country: country,
//                   state: state,
//                   city: city,
//                   dialogColor: Colors.grey.shade200,
//                   textFieldDecoration: InputDecoration(
//                       fillColor: Colors.blueGrey.shade100,
//                       filled: true,
//                       suffixIcon: const Icon(Icons.arrow_downward_rounded),
//                       border: const OutlineInputBorder(
//                           borderSide: BorderSide.none))),
//               SizedBox(height: 20),
//               Text("${country.text}, ${state.text}, ${city.text}")
//             ],
//           )),
//     );
//   }
// }
