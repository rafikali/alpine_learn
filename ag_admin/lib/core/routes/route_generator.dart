import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes/route_name.dart';
import 'package:flutter_application_1/home/home_screen.dart';
import 'package:flutter_application_1/qr_view/screen/qr_screen.dart';

import '../../auth/login/screen/login_screen.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    Object? arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginScreen());

      case Routes.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case Routes.qrScanView:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const QRViewExample());

      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginScreen());
    }
  }
}
