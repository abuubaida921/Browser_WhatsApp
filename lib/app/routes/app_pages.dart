import 'package:whatsapp_desktop_app/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:whatsapp_desktop_app/app/modules/forgot_password/views/forgot_password_screen.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_screen_binding.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/login/bindings/login_screen_binding.dart';
import '../modules/login/views/login_screen.dart';
import '../modules/registration/bindings/registration_screen_binding.dart';
import '../modules/registration/views/registration_screen.dart';
import '../modules/splash/bindings/splash_screen_binding.dart';
import '../modules/splash/views/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION_SCREEN,
      page: () => const RegistrationScreen(),
      binding: RegistrationScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_SCREEN,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
    ),
  ];
}
