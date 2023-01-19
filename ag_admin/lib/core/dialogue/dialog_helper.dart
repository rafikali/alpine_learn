import 'package:flutter/material.dart';

import '../services/navigation_service.dart';
import '../services/service_locator.dart';

Future<void> returnDialog(BuildContext context, statusText) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text(statusText), const CircularProgressIndicator()],
          ),
        );
      });
}

class DialogHelper {
  static showloadingDialog() {
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: locator<NavigationService>().getNavigationContext(),
      builder: (appContext) {
        return Material(
          // type: MaterialType.transparency,
          color: Colors.grey.withOpacity(0.4),
          child: const SizedBox(
            height: 150,
            child: Center(
              // child: CircularProgressIndicator(),
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  static hideDialog() {
    locator<NavigationService>().popDialog(true);
  }
}
