import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenPadding extends StatelessWidget {
  const ScreenPadding({
    super.key,
    this.child,
    this.padding,
  });
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w),
      child: child,
    );
  }
}
