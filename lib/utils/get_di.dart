
import 'package:aci_app/constants/app_constant.dart';
import 'package:aci_app/controller/auth_controller.dart';
import 'package:aci_app/repository/auth_repo.dart';
import 'package:aci_app/utils/apis/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => ApiClient(
        appBaseUrl: AppConstants.baseUrl,
        sharedPreferences: Get.find(),
      ));
 Get.lazyPut(() => AuthController(authRepo: Get.find()));
 Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Map<String, Map<String, String>> languages = {};

  return languages;
}
