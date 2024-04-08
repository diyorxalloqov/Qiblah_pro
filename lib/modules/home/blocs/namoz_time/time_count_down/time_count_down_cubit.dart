import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qiblah_pro/modules/home/blocs/namoz_time/namoz_time_bloc.dart';
import 'package:qiblah_pro/modules/home/blocs/namoz_time/time_count_down/time_count_down_state.dart';
import 'package:qiblah_pro/modules/home/service/namoz_time_service.dart';

class TimeCountDownCubit extends Cubit<TimeCountDownState> {
  TimeCountDownCubit() : super(const TimeCountDownState()) {
    _startCoundDown();
    _timer = Timer(Duration.zero, () {});
  }
  final NamozTimeService _namozTimeService = NamozTimeService();
  late Timer _timer;

  FutureOr<void> _startCoundDown() async {
    DateTime? nextPrayerTime = await _namozTimeService.getNextPrayerTime();
    if (nextPrayerTime == null) {
      // TODO mark so prayer time is not shown;
      return null;
    }

    _updateTime(nextPrayerTime);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime(nextPrayerTime);
      TodayNamozTimes();

      /// adding this
    });
  }

  FutureOr<void> _updateTime(DateTime nextPrayerTime) {
    DateTime now = DateTime.now();
    Duration durationUntilNextPrayer = nextPrayerTime.difference(now);

    if (durationUntilNextPrayer.inSeconds <= 0) {
      durationUntilNextPrayer = nextPrayerTime.difference(now);
    }
    emit(state.copyWith(durationUntilNextPrayer: durationUntilNextPrayer));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
