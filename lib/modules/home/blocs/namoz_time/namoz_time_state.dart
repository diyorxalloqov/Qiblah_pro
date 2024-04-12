part of 'namoz_time_bloc.dart';

class NamozTimeState extends Equatable {
  final String error;
  final ActionStatus status;
  final DailyPrayerTimes? dailyTimes;
  final List<DailyPrayerTimes> currentMonthTimes;
  final NamozTimeCalculation? chosenCalculationMethod;
  final Madhab chosenMadhab;
  final Duration durationUntilNextPrayer;
  final HighLatitudeRule chosenHighLatitudeRule;
  final double? latitude;
  final double? longtitude;
  final String? capital;

  const NamozTimeState(
      {this.error = '',
      this.capital,
      this.dailyTimes,
      this.durationUntilNextPrayer = const Duration(seconds: 0),
      this.status = ActionStatus.isInitial,
      this.chosenCalculationMethod,
      this.latitude ,
      this.longtitude,
      this.chosenHighLatitudeRule = HighLatitudeRule.twilight_angle,
      this.chosenMadhab = Madhab.hanafi,
      this.currentMonthTimes = const []});

  NamozTimeState copyWith(
      {String? error,
      List<DailyPrayerTimes>? currentMonthTimes,
      NamozTimeCalculation? chosenCalculationMethod,
      Madhab? chosenMadhab,
      double? latitude,
      double? longtitude,
      String? capital,
      Duration? durationUntilNextPrayer,
      ActionStatus? status,
      HighLatitudeRule? chosenHighLatitudeRule,
      DailyPrayerTimes? dailyTimes,
      List<DailyPrayerTimes>? currentWeekTimes}) {
    return NamozTimeState(
      error: error ?? this.error,
      capital: capital ?? this.capital,
      chosenCalculationMethod:
          chosenCalculationMethod ?? this.chosenCalculationMethod,
      durationUntilNextPrayer:
          durationUntilNextPrayer ?? this.durationUntilNextPrayer,
      latitude: latitude ?? this.latitude,
      longtitude: longtitude ?? this.longtitude,
      chosenHighLatitudeRule:
          chosenHighLatitudeRule ?? this.chosenHighLatitudeRule,
      status: status ?? this.status,
      chosenMadhab: chosenMadhab ?? this.chosenMadhab,
      currentMonthTimes: currentMonthTimes ?? this.currentMonthTimes,
      dailyTimes: dailyTimes,
    );
  }

  @override
  List<Object?> get props => [
        error,
        dailyTimes,
        currentMonthTimes,
        chosenCalculationMethod,
        chosenHighLatitudeRule,
        chosenMadhab,
        latitude,
        longtitude,
        durationUntilNextPrayer,
        status,
        capital
      ];
}
