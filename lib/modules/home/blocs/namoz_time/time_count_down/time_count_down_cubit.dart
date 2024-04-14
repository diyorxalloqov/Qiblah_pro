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
    // if (nextPrayerTime == null) {
    //   return null;
    // }
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

    if (durationUntilNextPrayer.inSeconds <= 0) {
      // debugPrint(
      //     "durationUntilNextPrayer $durationUntilNextPrayer 0 ga teng boldi");
      DateTime now1 = DateTime.now().toUtc();
      nextPrayerTime = nextPrayerTime.toUtc();
      Duration durationUntilNextPrayer = nextPrayerTime.difference(now1);
      emit(state.copyWith(durationUntilNextPrayer: durationUntilNextPrayer));
    }
    emit(state.copyWith(durationUntilNextPrayer: durationUntilNextPrayer));
  }

  void cancelTimes() => _timer.cancel();
}
