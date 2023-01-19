import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/app/get_headers.dart';
import 'package:flutter_application_1/core/services/api_handling/api_interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiManager {
  Dio? dio;
  final int _connectionTimeout = 30000;
  final int _receiveTimeout = 500000;

  ApiManager() {
    final options = BaseOptions(
        baseUrl: 'https://api-adm.ambition.guru',
        // baseUrl: '',
        connectTimeout: _connectionTimeout,
        receiveTimeout: _receiveTimeout,
        // contentType: Headers.jsonContentType,
        headers: getHeader());
    print(getHeader());

    dio = Dio(options);
    dio!.interceptors.add(
      ApiInterceptor(dioInstance: dio),
    );

    dio!.interceptors.add(
      PrettyDioLogger(
          request: false,
          responseBody: false,
          requestBody: false,
          requestHeader: false),
    );

    //this is for avoiding certificates error cause by dio
    //https://issueexplorer.com/issue/flutterchina/dio/1285
    //for handaling bad certificate uncomment it

    (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}
