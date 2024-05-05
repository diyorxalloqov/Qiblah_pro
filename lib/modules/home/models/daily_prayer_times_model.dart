import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

@immutable
class DailyPrayerTimes {
  final PrayerTime bomdod;
  final PrayerTime quyosh;
  final PrayerTime peshin;
  final PrayerTime asr;
  final PrayerTime shom;
  final PrayerTime xufton;

  const DailyPrayerTimes(
      {required this.bomdod,
      required this.quyosh,
      required this.peshin,
      required this.asr,
      required this.shom,
      required this.xufton});
}

class PrayerTime {
  DateTime time;
  bool isCurrent = false;

  PrayerTime(this.time, {this.isCurrent = false});
}
