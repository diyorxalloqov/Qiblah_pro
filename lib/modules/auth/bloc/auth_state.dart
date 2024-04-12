part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final ActionStatus status;
  final ActionStatus status1;
  final ActionStatus status2;
  final bool? isTemporaryUser;

  final String error;
  final String loginerror;
  final AuthModel? authModel;

  const AuthState(
      {this.error = '',
      this.loginerror = '',
      this.isTemporaryUser,
      this.status2 = ActionStatus.isInitial,
      this.status1 = ActionStatus.isInitial,
      this.authModel,
      this.status = ActionStatus.isInitial});

  AuthState copyWith(
      {ActionStatus? status,
      ActionStatus? status1,
      bool? isTemporaryUser,
      ActionStatus? status2,
      AuthModel? authModel,
      String? loginerror,
      String? error}) {
    return AuthState(
        error: error ?? this.error,
        isTemporaryUser: isTemporaryUser ?? this.isTemporaryUser,
        status2: status2 ?? this.status2,
        status1: status1 ?? this.status1,
        loginerror: loginerror ?? this.loginerror,
        authModel: authModel ?? this.authModel,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [status, status2, error, loginerror, status1, isTemporaryUser, authModel];
}
