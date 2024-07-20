import 'package:aci_app/constants/font_constant.dart';
import 'package:aci_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'apis/api_checker.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
      bool isIcon = false,
      bool isVpn = false,
      Duration? duration}) {
  if (isVpn) {
    SmartDialog.show(
      onDismiss: () async {
        if (await ApiChecker.isVpnActive()) {
          showCustomSnackBar('', isVpn: true, duration: const Duration(minutes: 7));
        }
      },
      alignment: Alignment.topCenter,
      builder: (_) {
        return Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.error,
          ),
          child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'please_disable_the_vpn'.tr,
                      style:FontConstant.styleRegular(fontSize: 14, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear, size: 25),
                      color: Colors.white,
                      onPressed: () {
                        SmartDialog.dismiss();
                      },
                    ),
                  ],
                ),
              )),
        );
      },
    );
  } else {
    // ignore: unnecessary_null_comparison
    if (message != null && message.isNotEmpty) {
      Get
        ..closeCurrentSnackbar()
        ..showSnackbar(GetSnackBar(
          snackPosition: SnackPosition.TOP,
          borderRadius: 5.0,
          margin: const EdgeInsets.all(16),
          message: message,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          backgroundColor: isError ? Colors.red : Colors.green,
          icon: isIcon
              ? IconButton(
              icon: const Icon(
                Icons.clear,
                size: 16,
              ),
              color: Colors.white,
              onPressed: () {
                Get.back();
              })
              : null,
        ));
    }
  }
}

void showCustomSnackBarSuccess(String message,
    {bool isError = true,
      bool isIcon = false,
      bool isVpn = false,
      Duration? duration}) {
  if (isVpn) {
    SmartDialog.show(
      onDismiss: () async {
        if (await ApiChecker.isVpnActive()) {
          showCustomSnackBar('', isVpn: true, duration: const Duration(minutes: 7));
        }
      },
      alignment: Alignment.topCenter,
      builder: (_) {
        return Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.error,
          ),
          child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'please_disable_the_vpn'.tr,
                      style: FontConstant.styleRegular(fontSize: 14, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear, size: 25),
                      color: Colors.white,
                      onPressed: () {
                        SmartDialog.dismiss();
                      },
                    ),
                  ],
                ),
              )),
        );
      },
    );
  } else {
    if (message.isNotEmpty) {
      Get
        ..closeCurrentSnackbar()
        ..showSnackbar(GetSnackBar(
          snackPosition: SnackPosition.TOP,
          borderRadius: 5.0,
          margin: const EdgeInsets.all(16),
          message: message,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          backgroundColor: Colors.green,
          icon: isIcon
              ? IconButton(
              icon: const Icon(
                Icons.clear,
                size: 16,
              ),
              color: Colors.white,
              onPressed: () {
                Get.back();
              })
              : null,
        ));
    }
  }
}
