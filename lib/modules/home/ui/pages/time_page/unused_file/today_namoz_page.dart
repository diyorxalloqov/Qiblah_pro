// import 'package:hijri/hijri_calendar.dart';
// import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
// import 'package:qiblah_pro/modules/home/blocs/namoz_time/namoz_time_bloc.dart';
// import 'package:qiblah_pro/modules/home/blocs/namoz_time/time_count_down/time_count_down_cubit.dart';
// import 'package:qiblah_pro/modules/home/models/daily_prayer_times_model.dart';
// import 'package:qiblah_pro/utils/extension/daily_prayer_time.dart';

// class TodayPrayerTimesRoute extends StatefulWidget {
//   const TodayPrayerTimesRoute({super.key});

//   @override
//   State<TodayPrayerTimesRoute> createState() => _TodayPrayerTimesRouteState();
// }

// class _TodayPrayerTimesRouteState extends State<TodayPrayerTimesRoute> {
//   HijriCalendar hijriToday = HijriCalendar.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => TimeCountDownCubit(),
//         child: BlocBuilder<NamozTimeBloc, NamozTimeState>(
//           builder: (context, state) {
//             if (state.error.isNotEmpty) {
//               return Text('Error: ${state.error}');
//             }
//             if (state.dailyTimes == null) {
//               // Handle the case where state is null
//               return const Center(child: CircularProgressIndicator());
//             }
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(hijriToday.fullDate()),
//                 // FutureBuilder(
//                 //     future:
//                 //         context.read<GeolocationCubit>().getChosenLocation(),
//                 //     builder: (context, snapshot) {
//                 //       return Text(
//                 //           snapshot.data?.region.toString() ?? 'region has not found');
//                 //     }),
//                 // BlocBuilder<TimeCountDownCubit, TimeCountDownState>(
//                 //   builder: (context, state) {
//                 //     return state.durationUntilNextPrayer != Duration.zero
//                 //         ? Text(state.durationUntilNextPrayer
//                 //             .getFormattedCountdown())
//                 //         : const SizedBox();
//                 //   },
//                 // ),
//                 PrayerTimeCard(Icons.sunny, 'Fajr', state.dailyTimes!.bomdod),
//                 PrayerTimeCard(
//                     Icons.sunny, 'Sunrise', state.dailyTimes!.quyosh),
//                 PrayerTimeCard(Icons.sunny, 'Dhuhr', state.dailyTimes!.peshin),
//                 PrayerTimeCard(Icons.sunny, 'Asr', state.dailyTimes!.asr),
//                 PrayerTimeCard(Icons.sunny, 'Maghrib', state.dailyTimes!.shom),
//                 PrayerTimeCard(Icons.sunny, 'Isha', state.dailyTimes!.xufton),
//                 ElevatedButton(
//                   child: const Text('settings'),
//                   onPressed: () {
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => PrayerSettingsRoute()));
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget PrayerTimeCard(IconData icon, String title, PrayerTime prayerTime) {
//     return Card(
//       color: prayerTime.isCurrent ? Colors.green : Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(icon),
//                 SizedBox(
//                   width: 16,
//                 ),
//                 Text(title),
//               ],
//             ),
//             Text(prayerTime.time.hhMM()),
//           ],
//         ),
//       ),
//     );
//   }
// }
