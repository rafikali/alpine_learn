part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  LoginEvent({required this.username, required this.password});
}

class OtpVerityLoginEvent extends AuthEvent {
  final String username;
  final String password;
  final int otp;
  OtpVerityLoginEvent({
    required this.username,
    required this.password,
    required this.otp,
  });
}
