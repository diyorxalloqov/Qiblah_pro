// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class PickImageEvent extends ProfileEvent {
  final ImageSource source;
  const PickImageEvent({required this.source});
  @override
  // TODO: implement props
  List<Object> get props => [source];
}

class GetUserdataForEdit extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetUserData extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangeUserDataEvent extends ProfileEvent {
  final String name;
  final String gender;
  final String phone;
  const ChangeUserDataEvent(
      {required this.name, required this.gender, required this.phone});

  @override
  // TODO: implement props
  List<Object> get props => [name, gender, phone];
}


class DeleteAccauntEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LogoutEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class ChangeAppLangEvent extends ProfileEvent {
  final String lang;
  const ChangeAppLangEvent({required this.lang});
  @override
  // TODO: implement props
  List<Object> get props => [lang];
}
class ChangePasswordEvent extends ProfileEvent {
  final String password;
  const ChangePasswordEvent({required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [password];
}
///
class ChangePremiumEvent extends ProfileEvent {
  final bool isPremium;
  const ChangePremiumEvent({required this.isPremium});
  @override
  // TODO: implement props
  List<Object> get props => [isPremium];
}
class ChangeLocationEvent extends ProfileEvent {
  const ChangeLocationEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

