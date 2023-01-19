import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_color.dart';
import 'ease_in_widget.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.debounceDuration,
    this.width,
    this.fontSize,
    this.buttonColor,
    this.height,
    this.borderRadius,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? borderRadius;
  final double? fontSize;
  final double? height;
  final int? debounceDuration;
  final Color? buttonColor;
  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  Timer? _debounce;
  late ValueNotifier<bool> _isEnabled;

  @override
  void initState() {
    _isEnabled = ValueNotifier<bool>(true);

    super.initState();
  }

  void onTap() async {
    _isEnabled.value = false;
    _debounce = Timer(Duration(seconds: widget.debounceDuration ?? 2),
        () => _isEnabled.value = true);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      builder: (context, isEnabled, _) {
        return EaseInWidget(
          onTap: isEnabled ? widget.onPressed : null,
          child: Container(
            width: widget.width ?? 350.w,
            height: widget.height ?? 38.h,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 10.r),
                color: widget.buttonColor ?? AppColors.primaryColor),
            child: Center(
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.white,
                      fontSize: widget.fontSize ?? 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        );
      },
      valueListenable: _isEnabled,
    );
  }
}

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  const DefaultButton({
    super.key,
    required this.onPressed,
    this.width,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

class DefaultTextButton extends StatelessWidget {
  final Function() onTap;
  final String buttonTitle;
  const DefaultTextButton(
      {Key? key, required this.onTap, required this.buttonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        buttonTitle,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class CustomIconOnlyButton extends StatelessWidget {
  const CustomIconOnlyButton(
      {super.key, this.onTap, required this.icon, required this.buttonColor});
  final Function()? onTap;
  final IconData icon;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: buttonColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(6.sp),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
