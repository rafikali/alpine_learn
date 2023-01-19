import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/appbar/ag-appbar.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/core/services/navigation_service.dart';
import 'package:flutter_application_1/core/services/service_locator.dart';
import 'package:flutter_application_1/widget/back_to_exit.dart';
import 'package:flutter_application_1/widget/confirmation_dialog.dart';
import 'package:flutter_application_1/widget/custom_text_button.dart';

import '../core/routes/route_name.dart';
import '../core/services/shared_preference_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackToExit(
      child: SafeArea(
        child: Scaffold(
          appBar: AgAppbar(
            title: 'Qr Scanner',
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  bool isConfirmed = await getConfirmationDialog(
                      'Do you want to Logout?',
                      context: context);
                  if (isConfirmed) {
                    locator<SharedPrefsServices>()
                        .clearOnlyOneData(AppConstants.accessToken);
                    locator<NavigationService>()
                        .pushNamedAndRemoveUntil(Routes.loginScreen, false);
                  }
                },
              ),
            ],
            showBackButton: false,
          ),
          body: Center(
            child: CustomTextButton(
                onPressed: () {
                  locator<NavigationService>().navigateTo(Routes.qrScanView);
                },
                text: 'Scan Qr'),
          ),
        ),
      ),
    );
  }
}
