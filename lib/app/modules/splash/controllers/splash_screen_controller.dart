import 'dart:async';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(
      const Duration(seconds: 5),
      () {
        if (prefs.getBool('login') == true) {
          Get.offAllNamed(Routes.HOME_SCREEN);
        } else {
          Get.offAllNamed(Routes.HOME_SCREEN);
        }
      },
    );
  }

  @override
  void onClose() {}
}
