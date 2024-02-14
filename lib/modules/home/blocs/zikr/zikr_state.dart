part of 'zikr_bloc.dart';

class ZikrState extends Equatable {
  final ActionStatus status;
  final String error;
  final bool isVibration;
  final List<ZikrModel> zikrModel;

  const ZikrState(
      {this.status = ActionStatus.isInitial,
      this.error = '',
      this.isVibration = false,
      this.zikrModel = const []});

  ZikrState copyWith({
    ActionStatus? status,
    String? error,
    bool? isVibration,
    List<ZikrModel>? zikrModel,
  }) {
    return ZikrState(
        error: error ?? this.error,
        status: status ?? this.status,
        zikrModel: zikrModel ?? this.zikrModel,
        isVibration: isVibration ?? this.isVibration);
  }

  @override
  List<Object?> get props => [status, error, zikrModel, isVibration];
}
