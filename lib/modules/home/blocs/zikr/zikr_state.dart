part of 'zikr_bloc.dart';

class ZikrState extends Equatable {
  final ActionStatus status;
  final String error;
  final bool isVibration;
  final List<ZikrCategoryModel> zikrCategroyModel;
  final List<ZikrModel> zikrModel;
  final ActionStatus zikrStatus;
  final String zikrError;
  final List<ZikrModel> savedZikrs;
  final ActionStatus savedZikrStatus;

  const ZikrState(
      {this.status = ActionStatus.isInitial,
      this.error = '',
      this.isVibration = false,
      
      this.zikrModel = const [],
      this.savedZikrs = const [],
      this.savedZikrStatus = ActionStatus.isInitial,
      this.zikrStatus = ActionStatus.isInitial,
      this.zikrError = '',
      this.zikrCategroyModel = const []});

  ZikrState copyWith({
    ActionStatus? status,
    String? error,
    List<ZikrModel>? zikrModel,
    ActionStatus? zikrStatus,
    String? zikrError,
    bool? isVibration,
    List<ZikrModel>? savedZikrs,
    ActionStatus? savedZikrStatus,
    List<ZikrCategoryModel>? zikrCategroyModel,
  }) {
    return ZikrState(
        error: error ?? this.error,
        savedZikrs: savedZikrs ?? this.savedZikrs,
        status: status ?? this.status,
        zikrCategroyModel: zikrCategroyModel ?? this.zikrCategroyModel,
        isVibration: isVibration ?? this.isVibration,
        zikrError: zikrError ?? this.zikrError,
        zikrModel: zikrModel ?? this.zikrModel,
        savedZikrStatus: savedZikrStatus ?? this.savedZikrStatus,
        zikrStatus: zikrStatus ?? this.zikrStatus);
  }

  @override
  List<Object?> get props => [
        status,
        error,
        zikrCategroyModel,
        isVibration,
        zikrStatus,
        zikrError,
        zikrModel,
        savedZikrs,
        savedZikrStatus,
      ];
}
