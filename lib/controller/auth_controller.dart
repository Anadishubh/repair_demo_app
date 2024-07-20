import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aci_app/constants/app_constant.dart';
import 'package:aci_app/repository/auth_repo.dart';
import 'package:aci_app/utils/models/beam_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});
  var subCategories = <SubCategory>[].obs;
  var isLoading = true.obs;

  /// Login Api==================================
  Future<Response> loginapi({
    required BuildContext context,
    String? name,
    String? number,
    String? emailid,
  }) async {
    // isLoad.value = true;
    update();
    Response response =
        await authRepo.login(name: name, number: number, emailid: emailid);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token'].toString());
      print('fghjkl${response.body}');
      Get.offAndToNamed('/dash');
    } else {
      // SmartDialog.dism//iss();
      // isLoad.value = false;
    }
    //  isLoad.value = false;
    update();
    return response;
  }

  String? getAuthToken() {
    return authRepo.getUserToken();
  }

  fetchSubCategories({int? categoryid}) async {
    String url = "${AppConstants.baseUrl}${AppConstants.subCategory}";

    String? token = Get.find<AuthController>().getAuthToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({"category_id": categoryid});

    try {
      isLoading(true);
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'] == 'Success') {
          subCategories.value = (data['data']['category'] as List)
              .map((item) => SubCategory.fromJson(item))
              .toList();
        }
        update();
      }
    } finally {
      isLoading(false);
    }
  }
}
