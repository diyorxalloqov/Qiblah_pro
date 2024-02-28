part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final ActionStatus status;
  final ActionStatus status1;

  final String error;
  final RegisterModel? registerModel;

  const AuthState(
      {this.error = '',
      this.status1 = ActionStatus.isInitial,
      this.registerModel,
      this.status = ActionStatus.isInitial});

  AuthState copyWith(
      {ActionStatus? status,
      ActionStatus? status1,
      RegisterModel? registerModel,
      String? error}) {
    return AuthState(
        error: error ?? this.error,
        status1: status1 ?? this.status1,
        registerModel: registerModel ?? this.registerModel,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status, error, status1, registerModel];
}
