import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSettings {
  static GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  ///[getGlobalContext] returns global context
  static BuildContext getGlobalContext() => navigatorState.currentContext!;
}

Future<bool> getConfirmationDialog(
  String questionTitle, {
  BuildContext? context,
  String mainHeading = "Confirm",
  String acceptKey = "Confirm",
  String? rejectKey,
  Color confirmBtnColor = Colors.red,
}) async {
  return await showDialog<bool>(
      context: context ?? AppSettings.navigatorState.currentContext!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.r),
          ),
          content: Builder(builder: (context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              // padding: EdgeInsets.all(5),
              // height: 80.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      mainHeading,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                      ),
                      child: Text(
                        questionTitle,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context, false),
                        child: Container(
                          height: 28.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.r),
                              color: Color(0xFFBABABA).withOpacity(0.24)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: Text(
                            rejectKey ?? 'Cancel',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () => Navigator.pop(context, true),
                        child: Container(
                          alignment: Alignment.center,
                          height: 28.h,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(3.r)),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          child: Text(
                            acceptKey,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        );

        // return AlertDialog(
        //   insetPadding: EdgeInsets.zero,
        //   title: Text(
        //     mainHeading,
        //     style: Theme.of(context).textTheme.headline3,
        //   ),
        //   content: Text(
        //     questionTitle,
        //     style: Theme.of(context).textTheme.bodyText1,
        //   ),
        //   actions: [
        // InkWell(
        //   onTap: () => Navigator.pop(context, false),
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        //     child: Text(
        //       "Cancel",
        //       style: Theme.of(context).textTheme.bodyText2,
        //     ),
        //   ),
        // ),
        // InkWell(
        //   onTap: () => Navigator.pop(context, true),
        //   child: Container(
        //     decoration: BoxDecoration(
        //         color: Theme.of(context).primaryColor,
        //         borderRadius: BorderRadius.circular(3.r)),
        //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        //     child: Text(
        //       "Confirm",
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyText1
        //           ?.copyWith(color: Colors.white),
        //     ),
        //   ),
        // )
        //   ],
        // );
      }).then((value) => value ?? false);
}
