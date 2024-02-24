part of 'namoz_time_bloc.dart';

class NamozTimeState extends Equatable {
  final String error;
  final ActionStatus status;
  final DailyPrayerTimes? dailyTimes;
  final List<DailyPrayerTimes> currentWeekTimes;
  final List<DailyPrayerTimes> currentMonthTimes;
  final NamozTimeCalculation? chosenCalculationMethod;
  final Madhab chosenMadhab;
  final HighLatitudeRule chosenHighLatitudeRule;

  const NamozTimeState(
      {this.error = '',
      this.dailyTimes,
      this.status = ActionStatus.isInitial,
      this.chosenCalculationMethod,
      this.chosenHighLatitudeRule = HighLatitudeRule.twilight_angle,
      this.chosenMadhab = Madhab.hanafi,
      this.currentMonthTimes = const [],
      this.currentWeekTimes = const []});

  NamozTimeState copyWith(
      {String? error,
      List<DailyPrayerTimes>? currentMonthTimes,
      NamozTimeCalculation? chosenCalculationMethod,
      Madhab? chosenMadhab,
      ActionStatus? status,
      HighLatitudeRule? chosenHighLatitudeRule,
      DailyPrayerTimes? dailyTimes,
      List<DailyPrayerTimes>? currentWeekTimes}) {
    return NamozTimeState(
      error: error ?? this.error,
      currentWeekTimes: currentWeekTimes ?? this.currentWeekTimes,
      chosenCalculationMethod:
          chosenCalculationMethod ?? this.chosenCalculationMethod,
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
        // currentWeekTimes,
        chosenCalculationMethod,
        chosenHighLatitudeRule,
        chosenMadhab,
      ];
}
