import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/services/api_handling/failure.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../toast/app_toast.dart';
import '../service_locator.dart';

Either<dynamic, dynamic> decodingApi(Response? response,
    {required Function fromJson, String? endPoint}) {
  List<int> successStatusCode = [200, 201];
  // final errorMessage = response?.data['errors'];

  if (successStatusCode.contains(response?.statusCode)) {
    final data = response?.data;
    switch (data.runtimeType) {
      case Map:
        return Left(fromJson(data));
      case List:
        List<dynamic> listDataFromApi = data;

        try {
          final haha = listDataFromApi.map((e) => fromJson(e)).toList();
          return Left(haha);
        } catch (e) {
          log(e.toString());
          return Right(Failure(message: e.toString()));
        }

      default:
        return Left(fromJson(data));
    }
  } else if (response?.statusCode == 500) {
    AppToasts().showToast(message: 'Server Error', isSuccess: false);
    getCachedResponse(endPoint);

    return Left(response?.data);
  } else if (response?.statusCode == 401) {
    AppToasts().showToast(message: 'Unauthorized', isSuccess: false);
  } else if (response?.statusCode == 400) {
    // log(response!.data!);
    // final message = response.data['message'];
    return Right(Failure.fromJson(response!.data));
    // return Right(response.data);
  } else if (response?.statusCode == 422) {
    // AppToasts().showToast(message: 'unProcessable content', isSuccess: false);
    return Right(response!.data);
  } else if (response?.data == null) {
    return Right(response?.data);
  } else {
    return Right(Failure(message: 'Something went wrong'));
  }
  return response?.data;
}

Either<dynamic, Failure> handlingParsing(Response response) {
  try {
    return Left(response);
  } catch (e) {
    return Right(Failure(message: 'Parsing Error'));
  }
}

http.Response? getCachedResponse(String? path) {
  final cacheValue = locator<SharedPreferences>().getString(path ?? '');
  if (cacheValue != null) {
    return http.Response(cacheValue, 200);
  } else {
    return null;
  }
}
