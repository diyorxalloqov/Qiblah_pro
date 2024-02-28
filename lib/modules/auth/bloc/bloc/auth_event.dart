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
  final String signInToken;

  const RegisterEvent(this.userEmail,
      {required this.countryCode,
      required this.phoneNumber,
      required this.signInToken,
      required this.password});
  @override
  // TODO: implement props
  List<Object> get props =>
      [countryCode, userEmail, signInToken, phoneNumber, password];
}

class RegisterTemporaryEvent extends AuthEvent {
  final String countryCode;
  final String signInToken;
  const RegisterTemporaryEvent(
      {required this.countryCode, required this.signInToken});

  @override
  // TODO: implement props
  List<Object> get props => [countryCode, signInToken];
}
