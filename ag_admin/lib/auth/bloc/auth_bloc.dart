import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/auth/login/model/login_model.dart';
import 'package:flutter_application_1/auth/login/repo/auth_repo.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/core/services/service_locator.dart';
import 'package:flutter_application_1/core/services/shared_preference_service.dart';
import 'package:flutter_application_1/core/toast/app_toast.dart';
import 'package:meta/meta.dart';

import '../../core/services/api_handling/failure.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _repo = AuthRepo();
  AuthBloc() : super(AuthState(status: AuthStatus.initial)) {
    on<LoginEvent>(_login);
    on<OtpVerityLoginEvent>(_verifyOtpLogin);
  }

  Future<void> _login(LoginEvent event, emit) async {
    emit(state.copyWith(status: AuthStatus.authenticating));
    final response =
        await _repo.requestOtpLogin(event.username, event.password);

    response.fold((l) {
      emit(state.copyWith(status: AuthStatus.otpSent, showOtpField: true));
    }, (r) {
      AppToasts().showToast(
          message: r.message ?? 'Something went wrong', isSuccess: false);
      emit(state.copyWith(status: AuthStatus.unauthenticated, failure: r));
    });
  }

  Future<void> _verifyOtpLogin(OtpVerityLoginEvent event, emit) async {
    emit(state.copyWith(status: AuthStatus.otpVerifying, showOtpField: true));
    final response =
        await _repo.verifyOtpLogin(event.username, event.password, event.otp);
    response.fold((l) {
      locator<SharedPrefsServices>()
          .setString(key: AppConstants.accessToken, value: l.data?.token ?? '');
      emit(
        state.copyWith(
            status: AuthStatus.otpVerified, showOtpField: false, model: l),
      );
    }, (r) {
      AppToasts().showToast(
          message: r.message ?? 'Something went wrong', isSuccess: false);
      emit(state.copyWith(
          status: AuthStatus.unauthenticated, failure: r, showOtpField: true));
    });
  }
}
