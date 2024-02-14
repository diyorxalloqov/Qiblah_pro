// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'on_boarding_bloc.dart';

@immutable
abstract class OnBoardingEvent extends Equatable {}

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

class UserDataEvent extends OnBoardingEvent {
  final String name;
  final int isMan;
  UserDataEvent({required this.name, required this.isMan});

  @override
  // TODO: implement props
  List<Object?> get props => [name, isMan];
}
