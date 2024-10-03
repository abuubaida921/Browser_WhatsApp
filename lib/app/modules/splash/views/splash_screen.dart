import 'package:whatsapp_desktop_app/app/core/assets/image_assets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.size.height,
        width: double.infinity,
        alignment: Alignment.center,
        child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.appLogo),
                fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
