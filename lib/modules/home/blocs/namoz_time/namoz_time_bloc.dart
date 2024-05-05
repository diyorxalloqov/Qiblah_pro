import 'package:adhan/adhan.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/services.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/daily_prayer_times_model.dart';
import 'package:qiblah_pro/modules/home/models/time_calculation_model.dart';
import 'package:qiblah_pro/modules/home/service/namoz_time_service.dart';
import 'package:qiblah_pro/modules/home/service/notification/notification_scheduler.dart';

part 'namoz_time_event.dart';
part 'namoz_time_state.dart';

class NamozTimeBloc extends Bloc<NamozTimeEvent, NamozTimeState> {
  final NamozTimeService _namozTimeService = NamozTimeService();
  // NotificationService services = NotificationService();

  NamozTimeBloc() : super(const NamozTimeState()) {
    on<CurrentNamozTimes>(_currentMonth);
    // add(const CurrentNamozTimes());
    on<LoadSettings>(_namozSettings);
    add(LoadSettings());
    on<ChangeSettings>(_changeNamozSettings);
    on<LocationSaveEvent>(_saveLocation);
    on<ScheduleNotificationsEvent>(_scheduleNotifications);
  }

  FutureOr<void> _currentMonth(
      CurrentNamozTimes event, Emitter<NamozTimeState> emit) async {
    emit(state.copyWith(status: ActionStatus.isLoading));
    var params = state.chosenCalculationMethod?.calculationParameters;
    params?.madhab = state.chosenMadhab;
    params?.highLatitudeRule = state.chosenHighLatitudeRule;
    debugPrint("${state.latitude} namoz bloc ${state.longtitude} ");

    try {
      List<DailyPrayerTimes> prayerTimes =
          await _namozTimeService.calculatePrayerTimesForMonth(
              1,
              params ?? CalculationParameters(fajrAngle: 0),
              state.latitude ?? StorageRepository.getDouble(Keys.latitude),
              state.longtitude ?? StorageRepository.getDouble(Keys.longitude));
      DailyPrayerTimes todayPrayerTimes =
          await _namozTimeService.calculatePrayerTimes(
              DateTime.now(),
              params ?? CalculationParameters(fajrAngle: 0),
              state.latitude ?? StorageRepository.getDouble(Keys.latitude),
              state.longtitude ?? StorageRepository.getDouble(Keys.longitude));
      emit(state.copyWith(
          status: ActionStatus.isSuccess,
          currentMonthTimes: prayerTimes,
          dailyTimes: todayPrayerTimes));
    } on ArgumentError catch (e) {
      emit(state.copyWith(error: 'error $e', status: ActionStatus.isError));
    }
  }
  //// working well

  FutureOr<void> _namozSettings(
      LoadSettings event, Emitter<NamozTimeState> emit) {
    NamozTimeCalculation timeCalculation =
        _namozTimeService.getChosenCalculationMethod();
    Madhab madhab = _namozTimeService.getChosenMadhab();
    HighLatitudeRule rule = _namozTimeService.getChosenHighLatitudeRule();
    debugPrint('salom ${timeCalculation.title}');
    debugPrint('hello ${madhab.name}');
    debugPrint('hi ${rule.name}');

    emit(state.copyWith(
        chosenCalculationMethod: timeCalculation,
        chosenMadhab: madhab,
        chosenHighLatitudeRule: rule));
    add(const CurrentNamozTimes());
  }

  FutureOr<void> _changeNamozSettings(
      ChangeSettings event, Emitter<NamozTimeState> emit) async {
    if (event.newValue is PrayerCalculationMethod) {
      await _namozTimeService.setChosenCalculationMethod(event.newValue);
    } else if (event.newValue is Madhab) {
      await _namozTimeService.setMadhab(event.newValue);
    } else if (event.newValue is HighLatitudeRule) {
      await _namozTimeService.setHighLatitudeRule(event.newValue);
    }
    add(LoadSettings());
  }

  FutureOr<void> _saveLocation(
      LocationSaveEvent event, Emitter<NamozTimeState> emit) {
    emit(state.copyWith(
        latitude: event.lat, longtitude: event.long, capital: event.capital));
  }

  Future<FutureOr<void>> _scheduleNotifications(
      ScheduleNotificationsEvent event, Emitter<NamozTimeState> emit) async {
    initAutoStart();
     ScheduledNotificationHelper()
        .schedulePrayNotification(state.currentMonthTimes);
  }

  Future<void> initAutoStart() async {
    try {
      //check auto-start availability.
      var test = await (isAutoStartAvailable as FutureOr<bool>);
      print(test);
      print('hello');
      //if available then navigate to auto-start setting page.
      if (test) await getAutoStartPermission();
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
