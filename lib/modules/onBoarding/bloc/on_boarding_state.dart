part of 'on_boarding_bloc.dart';

@immutable
class OnBoardingState extends Equatable {
  final double latitude;
  final double longitude;
  final String error;
  final String language;
  final bool isGarantedLocation;
  final bool isGarantedNotification;
  final ActionStatus status;

  const OnBoardingState({
    this.latitude = 0,
    this.longitude = 0,
    this.error = '',
    this.isGarantedNotification = false,
    this.language = '',
    this.isGarantedLocation = false,
    this.status = ActionStatus.isInitial,
  });

  OnBoardingState copyWith(
      {double? latitude,
      double? longitude,
      ActionStatus? status,
      String? error,
      bool? isGarantedNotification,
      bool? isGarantedLocation,
      String? language,
      int? currentIndex}) {
    return OnBoardingState(
        error: error ?? this.error,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        status: status ?? this.status,
        language: language ?? this.language,
        isGarantedNotification:
            isGarantedNotification ?? this.isGarantedNotification,
        isGarantedLocation: isGarantedLocation ?? this.isGarantedLocation);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [status, error, latitude, longitude, language, isGarantedLocation];
}
