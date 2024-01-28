import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

import 'package:qiblah_pro/modules/home/models/daily_prayer_times_model.dart';

extension Utils on DateTime {
  String hhMM() => DateFormat('HH:mm').format(this);
}

extension Converter on PrayerTimes {
  DailyPrayerTimes toDailyPrayerTimes() {
    return DailyPrayerTimes(
      fajr: PrayerTime(fajr, isCurrent: currentPrayer() == Prayer.fajr),
      sunrise:
          PrayerTime(sunrise, isCurrent: currentPrayer() == Prayer.sunrise),
      dhuhr: PrayerTime(dhuhr, isCurrent: currentPrayer() == Prayer.dhuhr),
      asr: PrayerTime(asr, isCurrent: currentPrayer() == Prayer.asr),
      maghrib:
          PrayerTime(maghrib, isCurrent: currentPrayer() == Prayer.maghrib),
      isha: PrayerTime(isha, isCurrent: currentPrayer() == Prayer.isha),
    );
  }
}
