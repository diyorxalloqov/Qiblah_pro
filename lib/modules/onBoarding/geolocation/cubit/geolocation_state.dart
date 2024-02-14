part of 'geolocation_cubit.dart';

@immutable
class GeolocationState extends Equatable {
  final LocationInfo? locationInfo;
  final PositionInfo? positionInfo;
  final List<PositionInfo> positionList;
  final ActionStatus status;

  const GeolocationState(
      {this.locationInfo,
      this.status = ActionStatus.isInitial,
      this.positionList = const [],
      this.positionInfo});

  GeolocationState copyWith(
      {ActionStatus? status,
      LocationInfo? locationInfo,
      List<PositionInfo>? positionList,
      PositionInfo? positionInfo}) {
    return GeolocationState(
        locationInfo: locationInfo ?? this.locationInfo,
        positionInfo: positionInfo ?? this.positionInfo,
        positionList: positionList ?? this.positionList,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [locationInfo, positionInfo, status, positionList];
}
