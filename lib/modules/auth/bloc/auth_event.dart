// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String countryCode;
  final String phoneNumber;
  final String password;
  final String userEmail;

  const RegisterEvent(this.userEmail,
      {required this.countryCode,
      required this.phoneNumber,
      required this.password});
  @override
  // TODO: implement props
  List<Object> get props => [countryCode, userEmail, phoneNumber, password];
}

class RegisterTemporaryEvent extends AuthEvent {
  final String countryCode;
  const RegisterTemporaryEvent({required this.countryCode});

  @override
  // TODO: implement props
  List<Object> get props => [countryCode];
}

class LoginEvent extends AuthEvent {
  final String phoneNumber;
  final String password;
  const LoginEvent({required this.password, required this.phoneNumber});
  @override
  // TODO: implement props
  List<Object> get props => [password, phoneNumber];
}
