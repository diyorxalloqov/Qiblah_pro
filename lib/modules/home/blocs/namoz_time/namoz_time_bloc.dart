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
    on<CurrentNamozTimes>(_currentMonth);
    // add(const CurrentNamozTimes());
    on<ScheduleNotificationEvent>(_scheduleNotification);
    on<LoadSettings>(_namozSettings);
    add(LoadSettings());
    on<ChangeSettings>(_changeNamozSettings);
    on<LocationSaveEvent>(_saveLocation);
  }

  FutureOr<void> _currentMonth(
      CurrentNamozTimes event, Emitter<NamozTimeState> emit) async {
    emit(state.copyWith(status: ActionStatus.isLoading));
    var params = state.chosenCalculationMethod?.calculationParameters;
    params?.madhab = state.chosenMadhab;
    params?.highLatitudeRule = state.chosenHighLatitudeRule;
    print("${state.latitude} namoz bloc ${state.longtitude} ");

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

  FutureOr<void> _scheduleNotification(
      ScheduleNotificationEvent event, Emitter<NamozTimeState> emit) async {
    add(const CurrentNamozTimes());
    var nextPrayerTime = await _namozTimeService.getNextPrayerTime(
        state.latitude ?? StorageRepository.getDouble(Keys.latitude),
        state.longtitude ?? StorageRepository.getDouble(Keys.longitude));
    try {
      var dailyTimes = state.dailyTimes;
      if (dailyTimes == null) {
        // Handle the case where dailyTimes is null
        return;
      }
      await services.init();
      debugPrint("${state.dailyTimes?.bomdod.time} time only ");

      DateTime now = DateTime.now().toUtc();
      DateTime nextPrayerTime1 = nextPrayerTime.toUtc();

      Duration duration = nextPrayerTime1.difference(now);

      if (event.namoz == NamozEnum.bomdod) {
        StorageRepository.getBool(Keys.bomdodNotification)
            ? Timer.periodic(duration, (timer) async {
                await services.setNotification(
                  // periodic qilsa boldi
                  body: 'Bomdod vaqti kirdi',
                  title: 'Bomdod',
                  date: state.dailyTimes?.bomdod.time ?? DateTime.now(),
                  id: 0,
                );
              })
            : await services.cancelNotification(0);
      } else if (event.namoz == NamozEnum.quyosh) {
        StorageRepository.getBool(Keys.quyoshNotification)
            ? Timer.periodic(duration, (timer) async {
                await services.setNotification(
                  // periodic qilsa boldi
                  body: 'Bomdod vaqti chiqdi',
                  title: 'Quyosh',
                  date: state.dailyTimes?.quyosh.time ?? DateTime.now(),
                  id: 1,
                );
              })
            : await services.cancelNotification(1);
      } else if (event.namoz == NamozEnum.peshin) {
        StorageRepository.getBool(Keys.peshinNotification)
            ? Timer.periodic(duration, (timer) async {
                await services.setNotification(
                  // periodic qilsa boldi
                  body: 'Peshin vaqti kirdi',
                  title: 'Peshin',
                  date: state.dailyTimes?.peshin.time ?? DateTime.now(),
                  id: 2,
                );
              })
            : await services.cancelNotification(2);
      } else if (event.namoz == NamozEnum.asr) {
        StorageRepository.getBool(Keys.asrNotification)
            ? Timer.periodic(duration, (timer) async {
                await services.setNotification(
                  // periodic qilsa boldi
                  body: 'Asr vaqti kirdi',
                  title: 'Asr',
                  date: state.dailyTimes?.asr.time ?? DateTime.now(),
                  id: 3,
                );
              })
            : await services.cancelNotification(3);
      } else if (event.namoz == NamozEnum.shom) {
        StorageRepository.getBool(Keys.shomNotification)
            ? Timer.periodic(duration, (timer) async {
                await services.setNotification(
                  // periodic qilsa boldi
                  body: 'Shom vaqti kirdi',
                  title: 'Shom',
                  date: state.dailyTimes?.shom.time ?? DateTime.now(),
                  id: 4,
                );
              })
            : await services.cancelNotification(4);
      } else if (event.namoz == NamozEnum.xufton) {
        StorageRepository.getBool(Keys.xuftonNotification)
            ? Timer.periodic(duration, (timer) async {
                await services.setNotification(
                  // periodic qilsa boldi
                  body: 'Xufton vaqti kirdi',
                  title: 'Xufton',
                  date: state.dailyTimes?.xufton.time ?? DateTime.now(),
                  id: 5,
                );
              })
            : await services.cancelNotification(5);
      } else if (event.namoz == NamozEnum.all) {
        /// hammasini periodic qilish kerak
        Timer.periodic(duration, (timer) async {
          await services.setNotification(
              body: 'Bomdod vaqti kirdi',
              title: 'Bomdod',
              date: state.dailyTimes?.bomdod.time ?? DateTime.now(),
              id: 0);
          await services.setNotification(
              body: 'Bomdod vaqti chiqdi',
              title: 'Quyosh',
              date: state.dailyTimes?.quyosh.time ?? DateTime.now(),
              id: 1);
          await services.setNotification(
              body: 'Peshin vaqti kirdi',
              title: 'Peshin',
              date: state.dailyTimes?.peshin.time ?? DateTime.now(),
              id: 2);
          await services.setNotification(
              body: 'Asr vaqti kirdi',
              title: 'Asr',
              date: state.dailyTimes?.asr.time ?? DateTime.now(),
              id: 3);
          await services.setNotification(
              body: 'Shom vaqti kirdi',
              title: 'Shom',
              date: state.dailyTimes?.shom.time ?? DateTime.now(),
              id: 4);
          await services.setNotification(
              body: 'Xufton vaqti kirdi',
              title: 'Xufton',
              date: state.dailyTimes?.xufton.time ?? DateTime.now(),
              id: 5);
        });
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

  FutureOr<void> _saveLocation(
      LocationSaveEvent event, Emitter<NamozTimeState> emit) {
    emit(state.copyWith(
        latitude: event.lat, longtitude: event.long, capital: event.capital));
  }
}
