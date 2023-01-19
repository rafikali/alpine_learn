import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';

import '../service_locator.dart';
import '../shared_preference_service.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({
    this.dioInstance,
  });
  final Dio? dioInstance;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    //We will save our access token while logging in and get here
    // and while communicating with api put if absent puts acesstoken if there
    // is not accessToken so that we don't have to pass it manually in every api
    // calls.
    final acessToken =
        locator<SharedPrefsServices>().getString(key: AppConstants.accessToken);
    // locator<SharedPreferences>().getString(AppConstants.accessToken);

    if (acessToken != null) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $acessToken');
    }
    return super.onRequest(options, handler);
  }
}
