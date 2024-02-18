// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

// class HiveUserDBService {
//   Box<PositionInfo>? positionBox; // Use 'late' to initialize later

//   static void registerAdapters() {
//     // Hive.registerAdapter(PositionInfoAdapter());
//   }

//   Future<void> openBox() async {
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     Hive.init(appDocDir.path);
//     positionBox = await Hive.openBox<PositionInfo>("DB");
//   }

//   Future<dynamic> getPosition() async {
//     try {
//       await openBox();
//       print('get func box not empty');
//       if (positionBox!.isNotEmpty) {
//         PositionInfo? data = positionBox!.get("myData");
//         print("$data hive data");
//         return data;
//       }
//     } on HiveError catch (e) {
//       print(e.message);
//       return null;
//     }
//   }

//   Future<void> writePosition(PositionInfo positionInfo) async {
//     try {
//       await openBox();
//       print('writing');
//       await positionBox?.put("myData", positionInfo);
//       print("${positionBox?.get('myData')} db data");
//       print(positionBox?.length);
//     } on HiveError catch (e) {
//       print(e.message);
//       print(e);
//     }
//   }
// }
