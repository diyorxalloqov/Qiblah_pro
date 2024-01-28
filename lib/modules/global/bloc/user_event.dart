// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserDataSaveEvent extends UserEvent {
  final UserModel user;

  const UserDataSaveEvent({required this.user});
  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class UserdataGetEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserDeleteEvent extends UserEvent {
  final int id;
  const UserDeleteEvent({required this.id});
  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class UserUpdateEvent extends UserEvent {
  final UserModel userModel;
  const UserUpdateEvent({required this.userModel});

  @override
  // TODO: implement props
  List<Object> get props => [userModel];
}
