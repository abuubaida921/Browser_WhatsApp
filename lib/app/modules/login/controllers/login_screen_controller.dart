import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final obscurePassword = true.obs;
  final loading = false.obs;
  final rememberMe = true.obs;
}
