part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  authenticating,
  otpSent,
  otpVerifying,
  unauthenticated,
  otpVerified
}

@immutable
// ignore: must_be_immutable
class AuthState extends Equatable {
  AuthStatus? status;
  LoginResponse? model;
  Failure? failure;
  bool showOtpField;

  @override
  List<Object?> get props => [status, failure, showOtpField];

  AuthState({this.status, this.failure, this.model, this.showOtpField = false});

  AuthState copyWith(
      {AuthStatus? status,
      Failure? failure,
      LoginResponse? model,
      bool? showOtpField}) {
    return AuthState(
      status: status ?? this.status,
      showOtpField: showOtpField ?? this.showOtpField,
      failure: failure ?? this.failure,
      model: model ?? this.model,
    );
  }
}
