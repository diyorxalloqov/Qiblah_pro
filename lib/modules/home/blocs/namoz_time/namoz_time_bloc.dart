import 'package:adhan/adhan.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/models/daily_prayer_times_model.dart';
import 'package:qiblah_pro/modules/home/models/time_calculation_model.dart';
import 'package:qiblah_pro/modules/home/service/namoz_time_service.dart';
import 'package:qiblah_pro/modules/home/service/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
part 'namoz_time_event.dart';
part 'namoz_time_state.dart';

class NamozTimeBloc extends Bloc<NamozTimeEvent, NamozTimeState> {
  final NamozTimeService _namozTimeService = NamozTimeService();
  NotificationServices services = NotificationServices();

  NamozTimeBloc() : super(const NamozTimeState()) {
    on<CurrentNamozTimes>(_currentMonth);
    add(const CurrentNamozTimes());
    on<ScheduleNotificationEvent>(_scheduleNotification);
    on<LoadSettings>(_namozSettings);
    add(LoadSettings());
    on<ChangeSettings>(_changeNamozSettings);
    add(const ScheduleNotificationEvent(namoz: NamozEnum.all));
  }

  FutureOr<void> _currentMonth(
      CurrentNamozTimes event, Emitter<NamozTimeState> emit) async {
    var params = state.chosenCalculationMethod?.calculationParameters;
    params?.madhab = state.chosenMadhab;
    params?.highLatitudeRule = state.chosenHighLatitudeRule;

    try {
      List<DailyPrayerTimes> prayerTimes =
          await _namozTimeService.calculatePrayerTimesForMonth(
              1, params ?? CalculationParameters(fajrAngle: 0));
      DailyPrayerTimes todayPrayerTimes =
          await _namozTimeService.calculatePrayerTimes(
              DateTime.now(), params ?? CalculationParameters(fajrAngle: 0));
      emit(state.copyWith(
          currentMonthTimes: prayerTimes, dailyTimes: todayPrayerTimes));
    } on ArgumentError catch (e) {
      emit(state.copyWith(error: 'error $e'));
    }
  }

  FutureOr<void> _scheduleNotification(
      ScheduleNotificationEvent event, Emitter<NamozTimeState> emit) async {
    try {
      var dailyTimes = state.dailyTimes;
      if (dailyTimes == null) {
        // Handle the case where dailyTimes is null
        return;
      }

      DateTime bomdodTime = dailyTimes.bomdod.time;

      // Convert bomdodTime to the timezone used by the Flutter Local Notifications plugin
      var timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
      var localBomdodTime = tz.TZDateTime.from(bomdodTime, tz.local);
      var localQuyoshTime =
          tz.TZDateTime.from(dailyTimes.quyosh.time, tz.local);
      var localPeshinTime =
          tz.TZDateTime.from(dailyTimes.peshin.time, tz.local);
      var localAsrTime = tz.TZDateTime.from(dailyTimes.asr.time, tz.local);
      var localShomTime = tz.TZDateTime.from(dailyTimes.shom.time, tz.local);
      var localXuftonTime =
          tz.TZDateTime.from(dailyTimes.xufton.time, tz.local);

      // Set the notification based on the event namoz
      debugPrint(localBomdodTime.toString());
      debugPrint(localQuyoshTime.toString());
      debugPrint(localPeshinTime.toString());
      debugPrint(localAsrTime.toString());
      debugPrint(localShomTime.toString());
      debugPrint(localXuftonTime.toString());
      if (event.namoz == NamozEnum.bomdod) {
        await services.setNotification(
          body: 'Bomdod vaqti kirdi',
          title: 'Bomdod',
          date: localBomdodTime,
          id: 0,
        );
      } else if (event.namoz == NamozEnum.quyosh) {
        await services.setNotification(
          body: 'Bomdod vaqti chiqdi',
          title: 'Quyosh',
          date: localQuyoshTime,
          id: 1,
        );
      } else if (event.namoz == NamozEnum.peshin) {
        await services.setNotification(
          body: 'Peshin vaqti kirdi',
          title: 'Peshin',
          date: localPeshinTime,
          id: 2,
        );
      } else if (event.namoz == NamozEnum.asr) {
        await services.setNotification(
          body: 'Asr vaqti kirdi',
          title: 'Asr',
          date: localAsrTime,
          id: 3,
        );
      } else if (event.namoz == NamozEnum.shom) {
        await services.setNotification(
          body: 'Shom vaqti kirdi',
          title: 'Shom',
          date: localShomTime,
          id: 4,
        );
      } else if (event.namoz == NamozEnum.xufton) {
        await services.setNotification(
          body: 'Xufton vaqti kirdi',
          title: 'Xufton',
          date: localXuftonTime,
          id: 5,
        );
      } else if (event.namoz == NamozEnum.all) {
        await services.setNotification(
            body: 'Bomdod vaqti kirdi',
            title: 'Bomdod',
            date: localBomdodTime,
            id: 0);
        await services.setNotification(
            body: 'Bomdod vaqti chiqdi',
            title: 'Quyosh',
            date: localQuyoshTime,
            id: 1);
        await services.setNotification(
            body: 'Peshin vaqti kirdi',
            title: 'Peshin',
            date: localPeshinTime,
            id: 2);
        await services.setNotification(
            body: 'Asr vaqti kirdi', title: 'Asr', date: localAsrTime, id: 3);
        await services.setNotification(
            body: 'Shom vaqti kirdi',
            title: 'Shom',
            date: localShomTime,
            id: 4);
        await services.setNotification(
            body: 'Xufton vaqti kirdi',
            title: 'Xufton',
            date: localXuftonTime,
            id: 5);
      }
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
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
}
