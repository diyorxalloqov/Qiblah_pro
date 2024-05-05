import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class TimeCountDownState extends Equatable {
  final Duration durationUntilNextPrayer;

  const TimeCountDownState({
    this.durationUntilNextPrayer = const Duration(seconds: 0),
  });

  TimeCountDownState copyWith({
    Duration? durationUntilNextPrayer,
  }) {
    return TimeCountDownState(
        durationUntilNextPrayer:
            durationUntilNextPrayer ?? this.durationUntilNextPrayer);
  }

  @override
  List<Object?> get props => [durationUntilNextPrayer];
}
