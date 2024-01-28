class DailyPrayerTimes {
  PrayerTime fajr;
  PrayerTime sunrise;
  PrayerTime dhuhr;
  PrayerTime asr;
  PrayerTime maghrib;
  PrayerTime isha;

  DailyPrayerTimes(
      {required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha});
}

class PrayerTime {
  DateTime time;
  bool isCurrent = false;

  PrayerTime(this.time, {this.isCurrent = false});
}
