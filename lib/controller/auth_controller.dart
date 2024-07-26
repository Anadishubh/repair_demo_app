import 'dart:convert';
import 'package:aci_app/route/route.dart';
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
  var questionaire = <String>[].obs;
  var isLoading = true.obs;
  var questions = <String>[].obs;
  var information = <String>[].obs;
  var image = <String>[].obs;
  var form = <String>[].obs;

  /// Login Api==================================
  Future<Response> loginapi({
    required BuildContext context,
    String? name,
    String? number,
    String? emailid,
  }) async {
    update();
    Response response =
        await authRepo.login(name: name, number: number, emailid: emailid);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token'].toString());
      Get.offAndToNamed(AppRoutes.bottomNav);
    } else {
      errorMessage.value = 'Login failed';
    }
    update();
    return response;
  }

  String? getAuthToken() {
    return authRepo.getUserToken();
  }

  // Example method that uses the token
  Future<void> fetchData() async {
    String? token = getAuthToken();
    if (token != null) {
      // Proceed with fetching data using the token
    } else {}
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

  var errorMessage = ''.obs;
  getquestionlistt(
      {int? categoryId, int? subcategoryId, int? questionId1}) async {
    String url = "${AppConstants.baseUrl}${AppConstants.questionsList}";

    String? token = Get.find<AuthController>().getAuthToken();

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "questionnaires_id": questionId1,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null &&
          data['data']['question_or_information'] is List) {
        var list = data['data']['question_or_information'] as List;
        questions.value = list.map((q) => q['question'].toString()).toList();
      } else {
        errorMessage.value = 'No question data available';
      }
    } else {
      errorMessage.value = 'No question data available';
    }
  }

  informationList(
      {int? categoryId, int? subcategoryId, int? questionId2}) async {
    String url = "${AppConstants.baseUrl}${AppConstants.questionsList}";

    String? token = Get.find<AuthController>().getAuthToken();

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "questionnaires_id": questionId2,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null &&
          data['data']['question_or_information'] is List) {
        var list = data['data']['question_or_information'] as List;
        information.value =
            list.map((q) => q['information'].toString()).toList();
        image.value = list.map((w) => w['bottom_image'].toString()).toList();
      } else {
        errorMessage.value = 'No question data available';
      }
    } else {
      errorMessage.value = 'No question data available';
    }
  }

  formList({int? categoryId, int? subcategoryId, int? questionId3}) async {
    String url = "${AppConstants.baseUrl}${AppConstants.questionsList}";

    String? token = Get.find<AuthController>().getAuthToken();

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "questionnaires_id": questionId3,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null &&
          data['data']['question_or_information'] is List) {
        var list = data['data']['question_or_information'] as List;
        form.value = list.map((q) => q['question'].toString()).toList();
      } else {
        errorMessage.value = 'No question data available';
      }
    } else {
      errorMessage.value = 'No question data available';
    }
  }

  fetchQuestionaire({int? categoryId, int? subcategoryId}) async {
    String url = "${AppConstants.baseUrl}${AppConstants.questions}";

    String? token = Get.find<AuthController>().getAuthToken();

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null && data['data'] is List) {
        var list = data['data'] as List;
        questionaire.value =
            list.map((q) => q['question_type'].toString()).toList();
      } else {
        errorMessage.value = 'No question data available';
      }
    } else {
      errorMessage.value = 'No question data available';
    }
  }
}
