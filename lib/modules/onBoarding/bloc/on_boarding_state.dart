part of 'on_boarding_bloc.dart';

@immutable
class OnBoardingState extends Equatable {
  final String error;
  final bool isGarantedLocation;
  final bool isGarantedNotification;
  final ActionStatus status;

  const OnBoardingState({
    this.error = '',
    this.isGarantedNotification = false,
    this.isGarantedLocation = false,
    this.status = ActionStatus.isInitial,
  });

  OnBoardingState copyWith({
    double? latitude,
    double? longitude,
    ActionStatus? status,
    String? error,
    bool? isGarantedNotification,
    bool? isGarantedLocation,
  }) {
    return OnBoardingState(
      error: error ?? this.error,
      status: status ?? this.status,
      isGarantedNotification:
          isGarantedNotification ?? this.isGarantedNotification,
      isGarantedLocation: isGarantedLocation ?? this.isGarantedLocation,
    );
  }

  @override
  List<Object?> get props => [status, error, isGarantedLocation];
}
