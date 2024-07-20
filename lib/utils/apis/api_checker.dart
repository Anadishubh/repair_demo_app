import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../route/route.dart';
import '../custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      if (Get.currentRoute != AppRoutes.signUp) {
        showCustomSnackBar(response.body['message'] ?? 'unauthorized'.tr, isIcon: true);
      }
    } else if (response.statusCode == 429) {
      showCustomSnackBar('to_many_login_attempts'.tr);
    } else if (response.statusCode == -1) {
      showCustomSnackBar('you are using vpn', isVpn: true, duration: const Duration(minutes: 10));
    } else {
      EasyLoading.dismiss();
      response.body['error'] != null
          ? showCustomSnackBar(response.body['error'], isError: true)
          : showCustomSnackBar(response.body['error'].toString(), isError: true);
    }
  }

  static void forgotcheckApi(Response response) {
    if (response.statusCode == 401) {
      if (Get.currentRoute != AppRoutes.signUp) {
        showCustomSnackBar(response.body['error'] ?? 'unauthorized'.tr, isIcon: true);
      }
    } else if (response.statusCode == 429) {
      showCustomSnackBar('to_many_login_attempts'.tr);
    } else if (response.statusCode == -1) {
      showCustomSnackBar('you are using vpn', isVpn: true, duration: const Duration(minutes: 10));
    } else {
      EasyLoading.dismiss();
      showCustomSnackBar(response.body['error'].toString(), isError: true);
    }
  }

  static void checkloginApi(Response response) {
    if (response.statusCode == 401) {
      showCustomSnackBar(response.body['error'].toString(), isIcon: true);
    } else if (response.statusCode == 429) {
      showCustomSnackBar('to_many_login_attempts'.tr);
    } else if (response.statusCode == -1) {
      showCustomSnackBar('you are using vpn', isVpn: true, duration: const Duration(minutes: 10));
    } else {
      EasyLoading.dismiss();
      showCustomSnackBar(response.body['error'].toString(), isError: true);
    }
  }

  static Future<bool> isVpnActive() async {
    bool isVpnActive;
    List<NetworkInterface> interfaces = await NetworkInterface.list(
      includeLoopback: false,
      type: InternetAddressType.any,
    );
    isVpnActive = interfaces.any((interface) =>
    interface.name.contains("tun") ||
        interface.name.contains("ppp") ||
        interface.name.contains("pptp"));
    return isVpnActive;
  }
}