// import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
// import 'package:qiblah_pro/modules/home/blocs/namoz_time/namoz_time_bloc.dart';

// class SettingPickerDialog<T extends Enum> extends StatelessWidget {
//   final List<T> choices;

//   const SettingPickerDialog({super.key, required this.choices});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: choices.length,
//       itemBuilder: (context, index) {
//         var choice = choices[index];
//         return ListTile(
//           title: Text(choice.name),
//           onTap: () {
//             context.read<NamozTimeBloc>().add(ChangeSettings(newValue: choice));
//             Navigator.pop(context);
//           },
//         );
//       },
//     );
//   }
// }
