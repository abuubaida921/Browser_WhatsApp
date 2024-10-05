import 'package:get/get.dart';
import 'package:whatsapp_desktop_app/controller.dart';


class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put<newBrowserController>(
      newBrowserController(),
    );
  }
}
