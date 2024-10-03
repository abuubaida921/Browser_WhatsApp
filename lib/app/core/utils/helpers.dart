import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../values/app_colors.dart';

class Helpers {
  Helpers._();

  static ProgressDialog? pr;

  static dynamic loadingDialog(BuildContext context) {
    pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);

    pr!.style(
        message: 'Loading....',
        borderRadius: 5.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
          padding: const EdgeInsets.all(10.0),
          child: const CircularProgressIndicator(),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.fastOutSlowIn,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: const TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));

    return pr;
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.blackColor,
      textColor: AppColors.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static successToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.greenColor,
      textColor: AppColors.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static errorToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.darkRedColor,
      textColor: AppColors.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.blackColor,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: AppColors.whiteColor,
    );
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }

  static customDeleteDialog({
    required VoidCallback doneOnTap,
    required BuildContext context,
    Widget? title,
    Widget? body,
    String? titleText,
    String? doneActionText,
    String? cancelActionText,
  }) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(15.0),
            title: Container(
                color: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: title ??
                    const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    )),
            titlePadding: const EdgeInsets.all(0.0),
            content: body ??
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Are you sure you want to delete Item?'),
                  ],
                ),
            actions: [
              TextButton(
                  onPressed: doneOnTap,
                  child: Text(
                    doneActionText ?? 'Delete',
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  )),
              TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    cancelActionText ?? 'Cancel',
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  )),
            ],
          );
        });
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
