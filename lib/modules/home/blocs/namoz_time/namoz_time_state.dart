part of 'namoz_time_bloc.dart';

class NamozTimeState extends Equatable {
  final String error;
  final DailyPrayerTimes? dailyTimes;
  // final List<DailyPrayerTimes> currentWeekTimes;
  final List<DailyPrayerTimes> currentMonthTimes;
  final NamozTimeCalculation? chosenCalculationMethod;
  final Madhab? chosenMadhab;
  final HighLatitudeRule? chosenHighLatitudeRule;

  const NamozTimeState({
    this.error = '',
    this.dailyTimes,
    this.chosenCalculationMethod,
    this.chosenHighLatitudeRule,
    this.chosenMadhab,
    this.currentMonthTimes = const [],
    // this.currentWeekTimes = const []
  });

  NamozTimeState copyWith({
    String? error,
    List<DailyPrayerTimes>? currentMonthTimes,
    NamozTimeCalculation? chosenCalculationMethod,
    Madhab? chosenMadhab,
    HighLatitudeRule? chosenHighLatitudeRule,
    DailyPrayerTimes? dailyTimes,
    // List<DailyPrayerTimes>? currentWeekTimes
  }) {
    return NamozTimeState(
      error: error ?? this.error,
      // currentWeekTimes: currentWeekTimes ?? this.currentWeekTimes,
      chosenCalculationMethod:
      chosenCalculationMethod ?? this.chosenCalculationMethod,
      chosenHighLatitudeRule:
      chosenHighLatitudeRule ?? this.chosenHighLatitudeRule,
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
