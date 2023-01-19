import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/app_constants.dart';
import '../core/services/service_locator.dart';
import '../core/services/shared_preference_service.dart';

Map<String, String> getHeader() {
  String? token = locator<SharedPrefsServices>().getString(
    key: AppConstants.accessToken,
  );
  // print(token.toString());
  String header = "Bearer $token";

  Map<String, String> headers;
  headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    if (token != null) "Authorization": header,
  };
  print(headers.toString());

  return headers;
}
