import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/app/get_headers.dart';
import 'package:flutter_application_1/core/services/api_handling/failure.dart';
import 'package:flutter_application_1/core/services/api_handling/network_reponse.dart';

import '../../auth/login/model/login_model.dart';
import '../../core/services/api_handling/decode_api_response.dart';

class QrRepo {
  final qrScan = "/api/v1/admin/qr-code-scanned";

  Future<int> scanQr(String uniqueKey) async {
    final response = await ApiResponse.getResponse(
        endPoint: qrScan,
        apiMethods: ApiMethods.post,
        options: Options(headers: getHeader()),
        body: {'unique_key': uniqueKey});
    print(getHeader());
    return response?.statusCode ?? 0;
  }
}
