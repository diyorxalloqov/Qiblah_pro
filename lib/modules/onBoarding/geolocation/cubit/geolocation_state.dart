part of 'geolocation_cubit.dart';

@immutable
class GeolocationState extends Equatable {
  final LocationStatusEnum locationStatusEnum;
  final AutoChoiceLocationModel? autoChoiceLocationModel;
  final ManualChoserModel? manualChoserModel;
  final ActionStatus status;
  final ActionStatus manualStatus;
  final String error;
  // final List<PositionInfo> positionList;

  const GeolocationState({
    this.locationStatusEnum = LocationStatusEnum.notRequested,
    this.manualChoserModel,
    this.error = '',
    this.manualStatus = ActionStatus.isInitial,
    this.status = ActionStatus.isInitial,
    this.autoChoiceLocationModel, // this.positionList = const [],
  });

  GeolocationState copyWith(
      {ActionStatus? status,
      ActionStatus? manualStatus,
      ManualChoserModel? manualChoserModel,
      LocationStatusEnum? locationStatusEnum,
      String? error,
      AutoChoiceLocationModel? autoChoiceLocationModel
      // List<PositionInfo>? positionList,
      }) {
    return GeolocationState(
        manualStatus: manualStatus ?? this.manualStatus,
        locationStatusEnum: locationStatusEnum ?? this.locationStatusEnum,
        manualChoserModel: manualChoserModel ?? this.manualChoserModel,
        error: error ?? this.error,
        autoChoiceLocationModel:
            autoChoiceLocationModel ?? this.autoChoiceLocationModel,
        status: status ?? this.status
        // positionList: positionList ?? this.positionList,
        );
  }

  @override
  List<Object?> get props => [
        locationStatusEnum,
        error,
        manualStatus,
        manualChoserModel,
        autoChoiceLocationModel,
        status, /* positionList */
      ];
}
