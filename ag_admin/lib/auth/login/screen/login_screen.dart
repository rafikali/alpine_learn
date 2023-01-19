import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/asset_source.dart';
import 'package:flutter_application_1/core/constants/form_validation.dart';
import 'package:flutter_application_1/core/services/navigation_service.dart';
import 'package:flutter_application_1/widget/custom_text_button.dart';
import 'package:flutter_application_1/widget/normal_text_field.dart';
import 'package:flutter_application_1/widget/screen_padding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

import '../../../core/routes/route_name.dart';
import '../../../core/services/service_locator.dart';
import '../../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileNumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _tokenController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.otpVerified) {
            locator<NavigationService>().navigateTo(Routes.homeScreen);
          }
        },
        child: Scaffold(
            body: ScreenPadding(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  Center(
                    child: SizedBox(
                      width: 250.w,
                      child: SvgPicture.asset(
                        AssetSource.appLogo,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Username',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 5.h),
                  NormalTextField(
                    prefixIcon: Icon(
                      CupertinoIcons.profile_circled,
                      color: AppColors.primaryColor,
                    ),
                    controller: _mobileNumController,
                    validator: FormValidator.nameValidator,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 5.h),
                  NormalTextField(
                    prefixIcon: Icon(
                      CupertinoIcons.lock_circle,
                      color: AppColors.primaryColor,
                    ),
                    controller: _passwordController,
                    validator: FormValidator.passValidator,
                    assetName: '',
                    isObscure: true,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state.showOtpField) {
                        return Pinput(
                          validator: (value) {
                            if (value?.length == 6) {
                              return null;
                            } else {
                              return '';
                            }
                          },
                          controller: _tokenController,
                          length: 6,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomTextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (state.showOtpField) {
                                locator<AuthBloc>().add(OtpVerityLoginEvent(
                                    username: _mobileNumController.text,
                                    password: _passwordController.text,
                                    otp: int.parse(_tokenController.text)));
                              } else {
                                locator<AuthBloc>().add(LoginEvent(
                                    username: _mobileNumController.text,
                                    password: _passwordController.text));
                              }
                            }
                          },
                          text: state.showOtpField ? 'Verify' : 'Login');
                    },
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
