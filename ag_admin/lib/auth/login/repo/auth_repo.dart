import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/auth/login/model/login_model.dart';
import 'package:flutter_application_1/core/services/api_handling/decode_api_response.dart';

import '../../../core/services/api_handling/failure.dart';
import '../../../core/services/api_handling/network_reponse.dart';

class AuthRepo {
  final _loginUrl = '/api/v1/admin/login';
  final _finalLoginUrl = '/api/v1/admin/final-login';

  Future<Either<LoginResponse, Failure>> requestOtpLogin(
      String username, String password) async {
    final response = await ApiResponse.getResponse(
        endPoint: _loginUrl,
        apiMethods: ApiMethods.post,
        body: {
          'username': username,
          'password': password,
        });
    print(response);
    return decodingApi(response, fromJson: LoginResponse.fromJson)
        .fold((l) => Left(l), (r) => Right(Failure.fromJson(r)));
  }

  Future<Either<LoginResponse, Failure>> verifyOtpLogin(
      String username, String password, int otp) async {
    final response = await ApiResponse.getResponse(
        endPoint: _finalLoginUrl,
        apiMethods: ApiMethods.post,
        body: {
          'username': username,
          'password': password,
          "otp_token": otp,
        });
    print(response);
    return decodingApi(response, fromJson: LoginResponse.fromJson)
        .fold((l) => Left(l), (r) => Right(Failure.fromJson(r)));
  }
}
