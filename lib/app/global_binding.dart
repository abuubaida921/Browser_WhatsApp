import 'package:get/get.dart';

import 'global_controller.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GlobalController>(GlobalController(), permanent: true);
  }
}