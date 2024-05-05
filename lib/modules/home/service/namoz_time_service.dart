import 'package:adhan/adhan.dart';
import 'package:qiblah_pro/core/constants/keys.dart';
import 'package:qiblah_pro/core/db/shared_preferences.dart';
import 'package:qiblah_pro/modules/home/models/daily_prayer_times_model.dart';
import 'package:qiblah_pro/modules/home/models/time_calculation_model.dart';
import 'package:qiblah_pro/utils/enums.dart';
import 'package:qiblah_pro/utils/extension/daily_prayer_time.dart';

class NamozTimeService {
  // Future<List<DailyPrayerTimes>> calculatePrayerTimesInRange(
  //     DateTime from, DateTime until) async {
  //   var list = <DailyPrayerTimes>[];

  //   while (from.isBefore(until) || from.isAtSameMomentAs(until)) {
  //     var dailyPrayerTimes = calculatePrayerTimes(from);
  //     list.add(await dailyPrayerTimes);
  //     from = from.add(const Duration(days: 1));
  //   }

  //   return list;
  // }

  Future<List<DailyPrayerTimes>> calculatePrayerTimesForMonth(
      int month, CalculationParameters params, double lat, double long) async {
    var list = <DailyPrayerTimes>[];

    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month + month, 0);

    while (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      var dailyPrayerTimes = calculatePrayerTimes(startDate, params, lat, long);
      list.add(await dailyPrayerTimes);
      startDate = startDate.add(const Duration(days: 1));
    }
    return list;
  }

  Future<DailyPrayerTimes> calculatePrayerTimes(DateTime dateTime,
      CalculationParameters params, double lat, double long) async {
    // var params = getChosenCalculationMethod().calculationParameters;
    // params.madhab = getChosenMadhab();
    // params.highLatitudeRule = getChosenHighLatitudeRule();
    return PrayerTimes(
            Coordinates(lat, long), DateComponents.from(dateTime), params)
        .toDailyPrayerTimes();
  }

  ///// for notification
  Future<DailyPrayerTimes> getPrayerTimesForNotification() async {
    var params = getChosenCalculationMethod().calculationParameters;
    params.madhab = getChosenMadhab();
    params.highLatitudeRule = getChosenHighLatitudeRule();
    print('WORKING NAMOZ TIMES');
    return PrayerTimes(
            Coordinates(StorageRepository.getDouble(Keys.latitude),
                StorageRepository.getDouble(Keys.longitude)),
            DateComponents.from(DateTime.now()),
            params)
        .toDailyPrayerTimes();
  }

  Future<DateTime> getNextPrayerTime(double lat, double long) async {
    var params = getChosenCalculationMethod().calculationParameters;
    params.madhab = getChosenMadhab();
    params.highLatitudeRule = getChosenHighLatitudeRule();
    var calculatedPrayerTimes = PrayerTimes(
        Coordinates(lat, long), DateComponents.from(DateTime.now()), params);

    switch (calculatedPrayerTimes.nextPrayer()) {
      case Prayer.none:
        return calculatedPrayerTimes.fajr;
      case Prayer.fajr:
        return calculatedPrayerTimes.fajr;
      case Prayer.sunrise:
        return calculatedPrayerTimes.sunrise;
      case Prayer.dhuhr:
        return calculatedPrayerTimes.dhuhr;
      case Prayer.asr:
        return calculatedPrayerTimes.asr;
      case Prayer.maghrib:
        return calculatedPrayerTimes.maghrib;
      case Prayer.isha:
        return calculatedPrayerTimes.isha;
    }
  }

  Future<void> setChosenCalculationMethod(
      PrayerCalculationMethod method) async {
    await StorageRepository.putInt(Keys.calculatingTimeType, method.index);
  }

  NamozTimeCalculation getChosenCalculationMethod() {
    int index = StorageRepository.getInt(Keys.calculatingTimeType);
    return calculationMethodDetails[index];
  }

  Future<void> setMadhab(Madhab madhab) async {
    await StorageRepository.putInt(Keys.madhab, madhab.index);
  }

  Madhab getChosenMadhab() {
    int index = StorageRepository.getInt(Keys.madhab);
    return Madhab.values[index];
  }

  Future<void> setHighLatitudeRule(HighLatitudeRule rule) async {
    await StorageRepository.putInt(Keys.setHighLatitudeRule, rule.index);
  }

  HighLatitudeRule getChosenHighLatitudeRule() {
    int index = StorageRepository.getInt(Keys.setHighLatitudeRule);
    return HighLatitudeRule.values[index];
  }
}

List<NamozTimeCalculation> calculationMethodDetails = [
  NamozTimeCalculation(
    codename: 'muslim_board_uzbekistan',
    title: 'Muslim board of Uzbekistan',
    calculationParameters: CalculationParameters(
        fajrAngle: 15.0, ishaAngle: 15.0, method: CalculationMethod.other),
  ),
  NamozTimeCalculation(
    codename: 'Muslim World League',
    title: 'Muslim World league',
    calculationParameters:
        CalculationMethod.muslim_world_league.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'egyptian',
    title: 'Egyptian',
    calculationParameters: CalculationMethod.egyptian.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'karachi',
    title: 'Karachi',
    calculationParameters: CalculationMethod.karachi.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'umm_al_qura',
    title: 'umm_al_qura',
    calculationParameters: CalculationMethod.umm_al_qura.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'dubai',
    title: 'dubai',
    calculationParameters: CalculationMethod.dubai.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'moon_sighting_committee',
    title: 'Moon Sighting Committee',
    calculationParameters:
        CalculationMethod.moon_sighting_committee.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'north_america',
    title: 'North America',
    calculationParameters: CalculationMethod.north_america.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'kuwait',
    title: 'Kuwait',
    calculationParameters: CalculationMethod.kuwait.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'qatar',
    title: 'Qatar',
    calculationParameters: CalculationMethod.qatar.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'singapore',
    title: 'Singapore',
    calculationParameters: CalculationMethod.singapore.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'turkey',
    title: 'Turkey',
    calculationParameters: CalculationMethod.turkey.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'tehran',
    title: 'Tehran',
    calculationParameters: CalculationMethod.tehran.getParameters(),
  )
];
