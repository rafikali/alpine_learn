import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/app/get_headers.dart';
import 'package:flutter_application_1/core/dialogue/dialog_helper.dart';
import 'package:flutter_application_1/core/services/api_handling/api_manager.dart';

import '../../toast/app_toast.dart';
import '../service_locator.dart';
import '../shared_preference_service.dart';

enum ApiMethods { get, post }

class ApiResponse {
  static final ApiManager _apiManger = locator<ApiManager>();
  static Future<Response?> getResponse(
      {required String endPoint,
      required ApiMethods apiMethods,
      Map<String, dynamic>? queryParams,
      dynamic body,
      bool showDialog = true,
      Options? options,
      bool shouldCache = false}) async {
    Response? response;
    // String fcmId =
    //     locator<SharedPrefsServices>().getString(key: AppConstants.uniqueId) ??
    //         '';
    if (showDialog) DialogHelper.showloadingDialog();
    try {
      if (apiMethods == ApiMethods.post) {
        response = await _apiManger.dio!.post(
          endPoint,
          data: body,
          queryParameters: queryParams,
          options: options ?? Options(headers: getHeader()),
        );
      } else {
        response = await _apiManger.dio!
            .get(endPoint, queryParameters: queryParams, options: options);
      }
      if (response.statusCode == 200 && shouldCache) {
        locator<SharedPrefsServices>()
            .setString(key: endPoint, value: response.data);
      }
    } on SocketException catch (_) {
      log(_.message);
      if (showDialog) DialogHelper.hideDialog();

      return AppToasts()
          .showToast(message: 'No Internet Connection', isSuccess: false);
    } on DioError catch (e) {
      if (showDialog) DialogHelper.hideDialog();

      return e.response;
    } catch (e) {
      if (showDialog) DialogHelper.hideDialog();

      log(e.toString());
      rethrow;
    }
    if (showDialog) DialogHelper.hideDialog();
    return response;
  }
}
