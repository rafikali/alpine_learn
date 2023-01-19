import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_constants.dart';

// ignore: must_be_immutable
class AgAppbar extends StatelessWidget with PreferredSizeWidget {
  final TabBar? bottom;
  final Color? backgroundColor;
  final double appbarHeight;
  final Widget? customLeadingWidget;
  final Widget? customTitleWidget;
  bool showNotification;
  bool showBackButton;
  final String? title;
  final List<Widget>? actions;
  VoidCallback? backButttonPress;

  AgAppbar({
    super.key,
    this.bottom,
    this.showBackButton = false,
    this.appbarHeight = 50,
    this.backButttonPress,
    this.backgroundColor,
    this.customLeadingWidget,
    this.showNotification = false,
    this.customTitleWidget,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      automaticallyImplyLeading: showBackButton,
      leading:
          // SvgPicture.asset(
          //   ImageConstants.arrowBack,
          //   height: 10.h,
          //   width: 10.w,
          // ),
          showBackButton
              ? IconButton(
                  // ignore: prefer_const_constructors
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: backButttonPress ?? () => Navigator.pop(context))
              : customLeadingWidget,
      elevation: 0,
      title: customTitleWidget ??
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontFamily: AppConstants.ibmFont,
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
          ),
      actions: actions ?? [],
      // centerTitle: true,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom == null ? appbarHeight.h : 90.h);
}
