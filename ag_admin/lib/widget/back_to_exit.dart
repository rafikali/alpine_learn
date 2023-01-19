import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants/app_color.dart';
import '../core/toast/app_toast.dart';

class BackToExit extends StatefulWidget {
  final Widget child;
  final bool showWarning;
  const BackToExit({super.key, required this.child, this.showWarning = true});

  @override
  State<BackToExit> createState() => _BackToExitState();
}

class _BackToExitState extends State<BackToExit> {
  DateTime? _currentBackPressTime;

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();

    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      AppToasts().showToast(
          message: "Tap back again  to exit app.",
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColors.blackColor
              : AppColors.white);

      return Future.value(false);
    } else {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
      // });

      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child,
    );
  }
}
