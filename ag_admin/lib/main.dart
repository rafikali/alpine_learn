import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auth/login/screen/login_screen.dart';
import 'core/routes/route_generator.dart';
import 'core/services/navigation_service.dart';
import 'core/services/service_locator.dart';

import 'core/services/shared_preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.wait(
    [
      setupLocator().then(
        (value) async => {
          await locator<SharedPrefsServices>().init(),
        },
      ),
    ],
  );
  String? token =
      locator<SharedPrefsServices>().getString(key: AppConstants.accessToken);

  runApp(MultiBlocProvider(
      providers: [BlocProvider.value(value: locator<AuthBloc>())],
      child: MyApp(
        token: token,
      )));
  FlutterNativeSplash.remove();
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String? token;
  MyApp({super.key, this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              alignment: Alignment.topCenter,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Easy Path Lab',
                  navigatorKey: NavigationService.navigatorKey,
                  onGenerateRoute: RouteGenerator.generateRoute,
                  home:
                      token != null ? const HomeScreen() : const LoginScreen(),
                ),
                // BlocBuilder<InternetCubit, InternetResult>(
                //     builder: (context, state) {
                //   if (!state.isConnected) {
                //     return Positioned(
                //         top: 120, child: const AnimatedNetworkShower());
                //   }
                //   return const SizedBox();
                // })
              ],
            ),
          ),
        );
      },
    );
  }
}
