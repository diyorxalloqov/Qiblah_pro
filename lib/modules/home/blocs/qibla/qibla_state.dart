part of 'qibla_cubit.dart';

class QiblaState extends Equatable {
  final ActionStatus status;

  const QiblaState({this.status = ActionStatus.isInitial});

  QiblaState copyWith({
    ActionStatus? status,
  }) {
    return QiblaState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
