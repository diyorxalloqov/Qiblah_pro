part of 'geolocation_cubit.dart';

@immutable
class GeolocationState extends Equatable {
  final LocationStatusEnum locationStatusEnum;
  final AutoChoiceLocationModel? autoChoiceLocationModel;
  final ManualChoserModel? manualChoserModel;
  final ActionStatus status;
  final ActionStatus manualStatus;
  final String error;
  final String country;
  final String capital;
  final double latitude;
  final double longtitude;

  const GeolocationState({
    this.locationStatusEnum = LocationStatusEnum.notRequested,
    this.manualChoserModel,
    this.error = '',
    this.capital = '',
    this.country = '',
    this.latitude = 0,
    this.longtitude = 0,
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
      String? country,
      String? capital,
      double? latitude,
      double? longtitude,
      AutoChoiceLocationModel? autoChoiceLocationModel}) {
    return GeolocationState(
        manualStatus: manualStatus ?? this.manualStatus,
        locationStatusEnum: locationStatusEnum ?? this.locationStatusEnum,
        manualChoserModel: manualChoserModel ?? this.manualChoserModel,
        error: error ?? this.error,
        country: country ?? this.country,
        capital: capital ?? this.capital,
        autoChoiceLocationModel:
            autoChoiceLocationModel ?? this.autoChoiceLocationModel,
        status: status ?? this.status,
        latitude: latitude ?? this.latitude,
        longtitude: longtitude ?? this.longtitude);
  }

  @override
  List<Object?> get props => [
        locationStatusEnum,
        error,
        manualStatus,
        manualChoserModel,
        autoChoiceLocationModel,
        status,
        country,
        latitude,
        longtitude,
        capital
      ];
}
