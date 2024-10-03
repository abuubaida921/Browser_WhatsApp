import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ForgotPasswordScreenController>(
      ForgotPasswordScreenController(),
    );
  }
}
