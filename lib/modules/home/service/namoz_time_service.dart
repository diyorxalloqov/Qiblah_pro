import 'package:adhan/adhan.dart';
import 'package:qiblah_pro/core/constants/keys.dart';
import 'package:qiblah_pro/core/db/shared_preferences.dart';
import 'package:qiblah_pro/modules/home/models/daily_prayer_times_model.dart';
import 'package:qiblah_pro/modules/home/models/time_calculation_model.dart';
import 'package:qiblah_pro/utils/enums.dart';
import 'package:qiblah_pro/utils/extension/daily_prayer_time.dart';

class NamozTimeService {
  Future<List<DailyPrayerTimes>> calculatePrayerTimesForPreviousMonth() async {
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month - 1, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month, 0);

    return await calculatePrayerTimesInRange(startDate, endDate);
  }

  Future<List<DailyPrayerTimes>> calculatePrayerTimesForNextMonth() async {
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month + 1, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month + 2, 0);

    return await calculatePrayerTimesInRange(startDate, endDate);
  }

  Future<List<DailyPrayerTimes>> calculatePrayerTimesInRange(
      DateTime from, DateTime until) async {
    var list = <DailyPrayerTimes>[];

    while (from.isBefore(until) || from.isAtSameMomentAs(until)) {
      var dailyPrayerTimes = calculatePrayerTimes(from);
      list.add(await dailyPrayerTimes);
      from = from.add(const Duration(days: 1));
    }

    return list;
  }

  Future<List<DailyPrayerTimes>> calculatePrayerTimesForMonth(int month) async {
    var list = <DailyPrayerTimes>[];

    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month + month, 0);

    while (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      var dailyPrayerTimes = calculatePrayerTimes(startDate);
      list.add(await dailyPrayerTimes);
      startDate = startDate.add(const Duration(days: 1));
    }

    // print(list.first.asr.time);
    // print(list.length);
    // print(list.first.bomdod.time);

    return list;
  }

  Future<DailyPrayerTimes> calculatePrayerTimes(DateTime dateTime) async {
    // print(location.latitude);
    // print(location.longitude);

    var params = getChosenCalculationMethod().calculationParameters;
    params.madhab = getChosenMadhab();
    params.highLatitudeRule = getChosenHighLatitudeRule();
    return PrayerTimes(
            Coordinates(StorageRepository.getDouble(Keys.latitude),
                StorageRepository.getDouble(Keys.longitude)),
            DateComponents.from(dateTime),
            params)
        .toDailyPrayerTimes();
  }

  Future<DateTime?> getNextPrayerTime() async {
    // print(location);
    var params = getChosenCalculationMethod().calculationParameters;
    params.madhab = getChosenMadhab();
    params.highLatitudeRule = getChosenHighLatitudeRule();
    var calculatedPrayerTimes = PrayerTimes(
        Coordinates(StorageRepository.getDouble(Keys.latitude),
            StorageRepository.getDouble(Keys.longitude)),
        DateComponents.from(DateTime.now()),
        params);
    switch (calculatedPrayerTimes.nextPrayer()) {
      case Prayer.none:
        return null;
      case Prayer.fajr:
        return calculatedPrayerTimes.fajr;
      case Prayer.sunrise:
        return calculatedPrayerTimes.dhuhr;
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
  // Future<DateTime?> getNextPrayerTime() async {
  //   var location = await LocationChooserService().getChosenLocation();
  //   if (location == null) {
  //     // Handle the case gracefully without throwing an exception
  //     print('Location is null');
  //     return null;
  //   }
  //   print('location has');
  //   print(location.latitude);
  //   print(location.longitude);

  //   var params = getChosenCalculationMethod().calculationParameters;
  //   params.madhab = getChosenMadhab();
  //   params.highLatitudeRule = getChosenHighLatitudeRule();

  //   var dateComponents = DateComponents.from(DateTime.now());
  //   var calculatedPrayerTimes = PrayerTimes(
  //     Coordinates(location.latitude, location.longitude),
  //     dateComponents,
  //     params,
  //   );

  //   switch (calculatedPrayerTimes.nextPrayer()) {
  //     case Prayer.fajr:
  //       return calculatedPrayerTimes.fajr;
  //     case Prayer.sunrise:
  //       return calculatedPrayerTimes.sunrise;
  //     case Prayer.dhuhr:
  //       return calculatedPrayerTimes.dhuhr;
  //     case Prayer.asr:
  //       return calculatedPrayerTimes.asr;
  //     case Prayer.maghrib:
  //       return calculatedPrayerTimes.maghrib;
  //     case Prayer.isha:
  //       return calculatedPrayerTimes.isha;
  //     default:
  //       // Handle cases where nextPrayer() doesn't match any Prayer type
  //       return null;
  //   }
  // }

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
    codename: 'muslim_world_league',
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
    title: 'moon_sighting_committee',
    calculationParameters:
        CalculationMethod.moon_sighting_committee.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'north_america',
    title: 'north_america',
    calculationParameters: CalculationMethod.north_america.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'kuwait',
    title: 'kuwait',
    calculationParameters: CalculationMethod.kuwait.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'qatar',
    title: 'qatar',
    calculationParameters: CalculationMethod.qatar.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'singapore',
    title: 'singapore',
    calculationParameters: CalculationMethod.singapore.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'turkey',
    title: 'turkey',
    calculationParameters: CalculationMethod.turkey.getParameters(),
  ),
  NamozTimeCalculation(
    codename: 'tehran',
    title: 'tehran',
    calculationParameters: CalculationMethod.tehran.getParameters(),
  )
];
