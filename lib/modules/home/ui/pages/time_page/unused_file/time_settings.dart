// import 'package:adhan/adhan.dart';
// import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
// import 'package:qiblah_pro/modules/home/blocs/namoz_time/namoz_time_bloc.dart';
// import 'package:qiblah_pro/modules/home/ui/time_page/page/unused_file/dialogs/setting_picker_dialog.dart';

// class PrayerSettingsRoute extends StatelessWidget {
//   const PrayerSettingsRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<NamozTimeBloc, NamozTimeState>(
//         builder: (context, state) {
//           return Column(
//             children: [
//               ListTile(
//                 title: const Text('Calculation method'),
//                 subtitle: Text(
//                     state.chosenCalculationMethod?.title ?? 'Hisoblash Usuli'),
//                 onTap: () {
//                   showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return const SettingPickerDialog(
//                             choices: PrayerCalculationMethod.values);
//                       });
//                 },
//               ),
//               ListTile(
//                 title: const Text('Madhab'),
//                 subtitle: Text(state.chosenMadhab.toString()),
//                 onTap: () {
//                   showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return const SettingPickerDialog(
//                             choices: Madhab.values);
//                       });
//                 },
//               ),
//               ListTile(
//                 title: const Text('HighLatitudeRule'),
//                 subtitle: Text(state.chosenHighLatitudeRule.toString()),
//                 onTap: () {
//                   showPickerDialog(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text('Location'),
//                 subtitle: Text(context
//                     .read<GeolocationCubit>()
//                     .getChosenLocation()
//                     .toString()),
//                 onTap: () {
//                   navigateToLocationChooser(context);
//                 },
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }

//   void navigateToLocationChooser(BuildContext context) {
//     // context.push(AutoChoiceLocation.route);
//   }

//   void showPickerDialog(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return const SettingPickerDialog(choices: HighLatitudeRule.values);
//         });
//   }
// }

