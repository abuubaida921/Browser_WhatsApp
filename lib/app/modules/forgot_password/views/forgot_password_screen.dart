import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/assets/image_assets.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_sizes.dart';
import '../../../routes/app_pages.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordScreenController> {
  const ForgotPasswordScreen({super.key});

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
                            'Reset Password',
                            style: GoogleFonts.publicSans(
                              textStyle: const TextStyle(
                                  color: AppColors.primaryTextColor,
                                  fontSize: AppSizes.primaryTextSize),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              'Please enter your registered email address to request a password reset',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.primaryTextColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
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
                        ],
                      ),
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
                                    'Request OTP',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
