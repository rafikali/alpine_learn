// ignore: depend_on_referenced_packages
import 'package:flutter_application_1/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/core/services/navigation_service.dart';
import 'package:flutter_application_1/core/services/shared_preference_service.dart';
import 'package:flutter_application_1/qr_view/cubit/qr_cubit.dart';
import 'package:get_it/get_it.dart';

import 'api_handling/api_manager.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<SharedPrefsServices>(SharedPrefsServices());
  locator.registerSingleton<ApiManager>(ApiManager());
  locator.registerSingleton<AuthBloc>(AuthBloc());
  locator.registerSingleton<QrCubit>(QrCubit());
}
