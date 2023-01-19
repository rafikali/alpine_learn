// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/app_color.dart';

class NormalTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final bool? readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final double? scale;
  final TextInputType? textInputType;
  final int? maxLength;
  final String? hintText;
  final String? assetName;
  final bool isObscure;
  final bool? filled;
  bool isAutoFocus;
  final TextAlign? textAlign;
  bool isUnderlineBorder;
  final String? counterText;
  final Function(String)? onChanged;
  final int? maxLines;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  NormalTextField({
    Key? key,
    this.controller,
    this.label,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.scale,
    this.textInputType,
    this.maxLength,
    this.hintText,
    this.assetName,
    this.isObscure = false,
    this.filled = true,
    this.isAutoFocus = false,
    this.textAlign,
    this.isUnderlineBorder = false,
    this.counterText = "",
    this.onChanged,
    this.maxLines = 1,
    this.floatingLabelBehavior,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _NormalTextFieldState createState() => _NormalTextFieldState();
}

class _NormalTextFieldState extends State<NormalTextField> {
  late bool _isObscure;
  late bool _obscureInitialized;

  @override
  void initState() {
    _isObscure = widget.isObscure;
    if (_isObscure) {
      _obscureInitialized = true;
    } else {
      _obscureInitialized = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: widget.onTap,
        autofocus: widget.isAutoFocus,
        readOnly: widget.readOnly ?? false,
        controller: widget.controller,
        cursorColor: Colors.black,
        obscureText: _isObscure,
        textAlign: widget.textAlign ?? TextAlign.start,
        validator: widget.validator,
        maxLines: widget.maxLines ?? 1,
        onChanged: widget.onChanged,
        keyboardType: widget.textInputType,
        maxLength: widget.maxLength,
        inputFormatters: widget.inputFormatters,
        minLines: 1,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(
            15.w,
            18.w,
            8.w,
            18.w,
          ),
          // isCollapsed: true,
          floatingLabelBehavior:
              widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
          filled: widget.filled,
          fillColor: widget.filled != null ? AppColors.loginFieldColor : null,
          //counterText: widget.counterText,
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color(0xFFCCC9C9), width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(9.r))),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color(0xFFCCC9C9), width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(9.r))),
          labelText: widget.label,
          hintText: widget.hintText,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          prefixIcon: widget.prefixIcon,
          prefixIconColor: AppColors.primaryColor,
          focusColor: AppColors.primaryColor,
          suffixIcon: widget.assetName != null
              ? _obscureInitialized
                  ? InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: SizedBox(
                          height: 24.h,
                          child: Icon(
                            _isObscure
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                            size: 24,
                          ),
                          // child: SvgPicture.asset(
                          //   _isObscure
                          //       ? ImageConstants.eyeHide
                          //       : ImageConstants.eyeShow,
                          //   height: 24.h,
                          //   width: 24,
                          // ),
                        ),
                      ))
                  : Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: SizedBox(
                        height: 24.h,
                        child: SvgPicture.asset(
                          widget.assetName!,
                          height: 24.h,
                          width: 24,
                        ),
                      ),
                    )
              : widget.suffixIcon,
          counterText: widget.counterText,
        ));
  }
}

class Scale extends StatelessWidget {
  final Widget child;
  final double? scaleRatio;
  const Scale({Key? key, required this.child, this.scaleRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scaleRatio ?? 0.9,
      child: child,
    );
  }
}
