part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  final ActionStatus status;
  final UserModel? userModel;
  final String error;

  const UserState(
      {this.status = ActionStatus.isInitial, this.error = '', this.userModel});

  UserState copyWith(
      {ActionStatus? status, String? error, UserModel? userModel}) {
    return UserState(
        status: status ?? this.status,
        error: error ?? this.error,
        userModel: userModel ?? this.userModel);
  }

  @override
  List<Object?> get props => [status, userModel, error];
}
