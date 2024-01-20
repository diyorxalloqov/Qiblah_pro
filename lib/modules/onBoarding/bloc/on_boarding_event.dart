part of 'on_boarding_bloc.dart';

@immutable
abstract class OnBoardingEvent extends Equatable {}

class LocationPermissionEvent extends OnBoardingEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeLanguageEvent extends OnBoardingEvent {
  final String selectedLanguageCode;

  ChangeLanguageEvent(this.selectedLanguageCode);

  @override
  List<Object?> get props => [selectedLanguageCode];
}

class NotificationPermissionEvent extends OnBoardingEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
