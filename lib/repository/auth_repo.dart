import 'package:aci_app/constants/app_constant.dart';
import 'package:aci_app/utils/apis/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login({
    String? name,
    String? number,
    String? emailid,
  }) async {
    return apiClient.postData(AppConstants.login,
        {"name": name, "email": emailid, "mobile_no": number});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token.toString();
    apiClient.updateHeader(token.toString());
    return await sharedPreferences.setString(
        AppConstants.token, token.toString());
  }
    String? getUserToken() {
    return sharedPreferences.getString(AppConstants.token);
  }
}
