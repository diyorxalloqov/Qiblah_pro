part of 'qibla_cubit.dart';

class QiblaState extends Equatable {
  final PositionInfo? positionInfo;

  const QiblaState({this.positionInfo});

  QiblaState copyWith({
    PositionInfo? positionInfo,
  }) {
    return QiblaState(positionInfo: positionInfo ?? this.positionInfo);
  }

  @override
  List<Object?> get props => [positionInfo];
}
