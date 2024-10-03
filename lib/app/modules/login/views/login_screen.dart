import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/assets/image_assets.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_screen_controller.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ---- App Logo Section ---- //
                          Image.asset(
                            ImageAssets.appLogo,
                            width: Get.width,
                            height: Get.height * .1,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Sign in',
                            style: GoogleFonts.publicSans(
                              textStyle: const TextStyle(
                                  color: AppColors.primaryTextColor,
                                  fontSize: AppSizes.primaryTextSize),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // ---- Email Text Field ---- //
                          TextFormField(
                            controller: controller.emailController.value,
                            focusNode: controller.emailFocusNode.value,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field is mandatory!";
                              } else if (GetUtils.isEmail(value)) {
                                return null;
                              } else {
                                return 'Please enter a valid Email';
                              }
                            },
                            onFieldSubmitted: (value) {
                              Helpers.fieldFocusChange(
                                  context,
                                  controller.emailFocusNode.value,
                                  controller.passwordFocusNode.value);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                ImageAssets.email,
                                color: AppColors.primaryIconColor,
                                scale: AppSizes.iconScaleSize,
                              ),
                              hintText: 'Enter your email',
                              hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: AppColors.inputFieldBorderColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: AppColors.inputFieldBorderColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: AppColors.inputFieldBorderColor)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // ---- Password Text Field ---- //
                          TextFormField(
                            controller: controller.passwordController.value,
                            focusNode: controller.passwordFocusNode.value,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: controller.obscurePassword.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field is mandatory!";
                              } else if (value.length < 8) {
                                return "Password must be at least 8 character";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              // Utils.fieldFocusChange(context, loginVM.emailFocusNode.value,
                              //     loginVM.passwordFocusNode.value);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                ImageAssets.lock,
                                color: AppColors.primaryIconColor,
                                scale: AppSizes.iconScaleSize,
                              ),
                              suffixIcon: InkWell(
                                child: Image.asset(
                                  controller.obscurePassword.value
                                      ? ImageAssets.eyeOff
                                      : ImageAssets.eyeOn,
                                  color: AppColors.primaryIconColor,
                                  scale: AppSizes.iconScaleSize,
                                ),
                                onTap: () {
                                  controller.obscurePassword.value =
                                      !controller.obscurePassword.value;
                                },
                              ),
                              hintText: 'Your password',
                              hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 14),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: AppColors.inputFieldBorderColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: AppColors.inputFieldBorderColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: AppColors.inputFieldBorderColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.rememberMe.value =
                                !controller.rememberMe.value;
                          },
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 0.7,
                                // Reduce the scale to decrease the size
                                child: Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: controller.rememberMe.value,
                                  activeColor: AppColors.primaryButtonColor,
                                  // inactiveThumbColor: Colors.grey,
                                  onChanged: (newValue) {
                                    // controller.rememberMe.value=newValue!;
                                  },
                                ),
                              ),
                              // Transform.scale(scale: .5,child: Switch(value: true, onChanged: (newVal){})),
                              const Text(
                                'Remember Me',
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.FORGOT_PASSWORD_SCREEN);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Forgot password?',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 271,
                      child: InkWell(
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            Helpers.successToastMessage('form ok');
                          } else {
                            Helpers.errorToastMessage('form error');
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.all(0),
                          height: 50,
                          width: Get.size.width,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    AppColors.primaryButtonColor,
                                    AppColors.primaryButtonColor
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              //color: buttonColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: controller.loading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : Center(
                                  child: Text(
                                    'Login',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text('OR'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don’t have an account?',
                          style: TextStyle(
                              color: AppColors.primaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        // ---- Sign Up Text Button  ---- //
                        TextButton(
                            style: const ButtonStyle(
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.all(0))),
                            onPressed: () {
                              Get.toNamed(Routes.REGISTRATION_SCREEN);
                            },
                            child: const Text('Register',style: TextStyle(color: AppColors.primaryColor),))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
