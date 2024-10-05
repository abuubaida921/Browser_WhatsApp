import 'package:get/get.dart';
import 'package:whatsapp_desktop_app/new_browser.dart';

import 'binding.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => const InAppWebViewNew(),
      binding: Binding(),
    ),
  ];
}


abstract class Routes {
  Routes._();
  static const HOME_SCREEN = _Paths.HOME_SCREEN;
}

abstract class _Paths {
  _Paths._();
  static const HOME_SCREEN = '/home-screen';
}

