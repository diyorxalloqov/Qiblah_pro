part of 'geolocation_cubit.dart';

@immutable
class GeolocationState extends Equatable {
  final LocationInfo? locationInfo;
  final PositionInfo? positionInfo;

  const GeolocationState({this.locationInfo, this.positionInfo});

  GeolocationState copyWith(
      {ActionStatus? status,
      LocationInfo? locationInfo,
      PositionInfo? positionInfo}) {
    return GeolocationState(
        locationInfo: locationInfo ?? this.locationInfo,
        positionInfo: positionInfo ?? this.positionInfo);
  }

  @override
  List<Object?> get props => [locationInfo, positionInfo];
}
