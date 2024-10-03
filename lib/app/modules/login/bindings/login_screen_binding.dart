import 'package:get/get.dart';

import '../controllers/login_screen_controller.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginScreenController>(
      LoginScreenController(),
    );
  }
}
