import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/home/service/namoz_time_service.dart';

class TimeCountDownCubit extends Cubit<TimeCountDownState> {
  TimeCountDownCubit() : super(const TimeCountDownState()) {
    _timer = Timer(Duration.zero, () {});
  }
  final NamozTimeService _namozTimeService = NamozTimeService();
  late Timer _timer;

  FutureOr<void> startCoundDown(double lat, double long) async {
    DateTime nextPrayerTime =
        await _namozTimeService.getNextPrayerTime(lat, long);
    debugPrint("$nextPrayerTime NEXT TIME IS");
    _updateTime(nextPrayerTime);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      _updateTime(nextPrayerTime);
    });
  }

  FutureOr<void> _updateTime(DateTime nextPrayerTime) {
    DateTime now = DateTime.now().toUtc();
    nextPrayerTime = nextPrayerTime.toUtc();

    Duration durationUntilNextPrayer = nextPrayerTime.difference(now);

    if (durationUntilNextPrayer.inSeconds == 0) {
      print('duration nol ga teng');
      emit(state.copyWith(
          durationUntilNextPrayer:
              nextPrayerTime.toUtc().difference(DateTime.now().toUtc())));
    }

    //// bu keyingi namoz vaqti bir kun orqaga qolganda 1 kun qo'shib qo'yilgan
    if (durationUntilNextPrayer.inSeconds <= 0) {
      nextPrayerTime = nextPrayerTime.add(const Duration(days: 1));
      durationUntilNextPrayer = nextPrayerTime.difference(now);
      emit(state.copyWith(durationUntilNextPrayer: durationUntilNextPrayer));
    }
    emit(state.copyWith(durationUntilNextPrayer: durationUntilNextPrayer));
  }

  void cancelTimes() => _timer.cancel();
}
