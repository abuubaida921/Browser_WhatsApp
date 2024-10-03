import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/registration_screen_controller.dart';

class RegistrationScreen extends GetView<RegistrationScreenController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Registration'),),
    );
  }
}
