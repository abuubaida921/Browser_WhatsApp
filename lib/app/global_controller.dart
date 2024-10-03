import 'package:whatsapp_desktop_app/app/routes/app_pages.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/helpers.dart';

class GlobalController extends GetxController {
  GlobalController get to => Get.find();

  late SharedPreferences prefs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void onReady() async {
    super.onReady();
    prefs = await SharedPreferences.getInstance();
    print("User Tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn ${prefs.getString('user_token')}");
  }

  Future<bool> checkInternetConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return false;
    }
  }

  void signOutUser() async {
    try {
      await prefs.remove('user_token');
      await prefs.remove('user_id');
      Get.offAllNamed(Routes.HOME_SCREEN);
    } catch (error) {
      Helpers.errorToastMessage(error.toString());
    }
  }
}
