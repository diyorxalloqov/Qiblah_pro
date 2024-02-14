import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/daily_prayer_times_model.dart';
import 'package:qiblah_pro/modules/home/models/time_calculation_model.dart';
import 'package:qiblah_pro/modules/home/service/namoz_time_service.dart';
import 'package:qiblah_pro/modules/home/service/notification_service.dart';

part 'namoz_time_event.dart';
part 'namoz_time_state.dart';

class NamozTimeBloc extends Bloc<NamozTimeEvent, NamozTimeState> {
  final NamozTimeService _namozTimeService = NamozTimeService();
  NotificationServices services = NotificationServices();

  NamozTimeBloc() : super(const NamozTimeState()) {
    on<TodayNamozTimes>(_getTodayTimes);
    // add(TodayNamozTimes());
    on<CurrentMonthNamozTimes>(_currentMonth);
    on<ScheduleNotificationEvent>(_scheduleNotification);
    // add(CurrentMonthNamozTimes());  add ni ui da button bosilganda ishlatilyapdi

    /// ishlatilmadi
    // on<LoadSettings>(_namozSettings);
    // add(LoadSettings());
    // on<ChangeSettings>(_changeNamozSettings);
  }

  FutureOr<void> _getTodayTimes(
      TodayNamozTimes event, Emitter<NamozTimeState> emit) async {
    try {
      DailyPrayerTimes todayPrayerTimes =
          await _namozTimeService.calculatePrayerTimes(DateTime.now());
      print(todayPrayerTimes.bomdod.time);
      emit(state.copyWith(dailyTimes: todayPrayerTimes));
    } on ArgumentError catch (e) {
      print(e.message);
      emit(state.copyWith(error: 'error $e'));
    }
  }

  FutureOr<void> _currentMonth(
      CurrentMonthNamozTimes event, Emitter<NamozTimeState> emit) async {
    try {
      List<DailyPrayerTimes> prayerTimes =
          await _namozTimeService.calculatePrayerTimesForMonth(1);
      emit(state.copyWith(currentMonthTimes: prayerTimes));
    } on ArgumentError catch (e) {
      emit(state.copyWith(error: 'error $e'));
    }
  }

  FutureOr<void> _scheduleNotification(
      ScheduleNotificationEvent event, Emitter<NamozTimeState> emit) async {
    if (event.namoz == NamozEnum.bomdod) {
      await services.setNotification(
          body: 'Bomdod vaqti kirdi',
          title: 'bomdod',
          date: state.dailyTimes!.bomdod.time,
          id: 0);
    } else if (event.namoz == NamozEnum.quyosh) {
      await services.setNotification(
          body: 'Bomdod vaqti chiqdi',
          title: 'bomdod',
          date: state.dailyTimes!.quyosh.time,
          id: 1);
    } else if (event.namoz == NamozEnum.peshin) {
      await services.setNotification(
          body: 'Peshin vaqti kirdi',
          title: 'Peshin',
          date: state.dailyTimes!.peshin.time,
          id: 2);
    } else if (event.namoz == NamozEnum.asr) {
      await services.setNotification(
          body: 'Asr vaqti kirdi',
          title: 'Asr',
          date: state.dailyTimes!.asr.time,
          id: 3);
    } else if (event.namoz == NamozEnum.shom) {
      await services.setNotification(
          body: 'Shom vaqti kirdi',
          title: 'Shom',
          date: state.dailyTimes!.shom.time,
          id: 4);
    } else if (event.namoz == NamozEnum.xufton) {
      await services.setNotification(
          body: 'Xufton vaqti kirdi',
          title: 'Xufton',
          date: state.dailyTimes!.xufton.time,
          id: 5);
    } else if (event.namoz == NamozEnum.all) {
      await services.setNotification(
          body: 'Bomdod vaqti kirdi',
          title: 'Bomdod',
          date: state.dailyTimes!.bomdod.time,
          id: 0);
      await services.setNotification(
          body: 'Bomdod vaqti chiqdi',
          title: 'Quyosh',
          date: state.dailyTimes!.quyosh.time,
          id: 1);
      await services.setNotification(
          body: 'Peshin vaqti kirdi',
          title: 'Peshin',
          date: state.dailyTimes!.peshin.time,
          id: 2);
      await services.setNotification(
          body: 'Asr vaqti kirdi',
          title: 'Asr',
          date: state.dailyTimes!.asr.time,
          id: 3);
      await services.setNotification(
          body: 'Shom vaqti kirdi',
          title: 'Shom',
          date: state.dailyTimes!.shom.time,
          id: 4);
      await services.setNotification(
          body: 'Xufton vaqti kirdi',
          title: 'Xufton',
          date: state.dailyTimes!.xufton.time,
          id: 5);
    }
  }

  //unused for now

  ///// TODO settings is not used in ui if need to ui using namoz time type and madhab -- ui ga boglanmagan kerak bo'lsa boglab qoyamiz

  FutureOr<void> _namozSettings(
      LoadSettings event, Emitter<NamozTimeState> emit) {
    NamozTimeCalculation timeCalculation =
        _namozTimeService.getChosenCalculationMethod();
    Madhab madhab = _namozTimeService.getChosenMadhab();
    HighLatitudeRule rule = _namozTimeService.getChosenHighLatitudeRule();
    emit(state.copyWith(
        chosenCalculationMethod: timeCalculation,
        chosenMadhab: madhab,
        chosenHighLatitudeRule: rule));
    // Re-calculates the time to show correct prayer times
    add(TodayNamozTimes());
    // add(CurrentWeekNamozTimes());
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
}
