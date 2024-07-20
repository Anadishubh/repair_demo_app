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

//   Future<Response> deleteaccount({int? number, int? firebaseotp}) async {
//     return apiClient.postData(ApiConstants.deleteul, {});
//   }

//   Future<Response> dietitianList({String? number}) async {
//     return apiClient.postData(ApiConstants.dietitianList, {});
//   }

//   Future<Response> feedbackkklistdataa() async {
//     return apiClient.getData(
//       ApiConstants.feedbackchanck,
//     );
//   }

//   Future<Response> addUserRemarks(
//       {String? addRemarks,
//       String? addSpecialInstrction,
//       String? formattedDate,
//       String? p_userId}) async {
//     return apiClient.postData(ApiConstants.addUserRemarks, {
//       "p_user_id": p_userId,
//       "remarks": addRemarks,
//       "special_instruction": addSpecialInstrction,
//       "remarks_date": formattedDate,
//     });
//   }

//   Future<Response> LogoutPage({String? number}) async {
//     return apiClient.postData(ApiConstants.logout, {});
//   }

//   Future<Response> dietitianLogin({String? number, String? password}) async {
//     return apiClient.postData(
//         ApiConstants.dietitianLogin, {"user_id": number, "password": password});
//   }

//   Future<Response> feedbackpostapiii(
//       {String? shareprogram, String? message}) async {
//     return apiClient.postData(ApiConstants.feedbackapipost,
//         {"share_program": shareprogram, "message": message});
//   }

//   Future<Response> ratingpostapiii({double? rating, String? duserid}) async {
//     return apiClient.postData(ApiConstants.ratingpostapi,
//         {"rating": rating, "d_user_id": duserid, "comment": 'comment'});
//   }

//   Future<Response> dietitianFCMToken({String? token}) async {
//     return apiClient.postData(ApiConstants.saveDietitianToken, {
//       "app_token": token,
//     });
//   }

//   Future<Response> userFCMToken({String? token}) async {
//     return apiClient.postData(ApiConstants.userAddToken, {
//       "app_token": token,
//     });
//   }

//   Future<Response> dietitianDetails({int? page, String? filtername}) async {
//     return apiClient.postData(
//         ApiConstants.dietitianList, {'page': page, 'name': filtername});
//   }

//   Future<Response> chatAudioHistoryDetails({int? page}) async {
//     return apiClient.postData(ApiConstants.audio_chat, {
//       "page": page,
//     });
//   }

//   Future<Response> weeklyydocotordietsss(
//       {String? templeteidd, String? puseridd}) async {
//     return apiClient.postData(ApiConstants.weeklyydietsssdoctor,
//         {"diet_template_id": templeteidd, "p_user_id": puseridd});
//   }

//   Future<Response> specaillldocotordietsss(
//       {String? templeteidd, String? puseridd}) async {
//     return apiClient.postData(ApiConstants.specialllldeyislsssdocotr,
//         {"special_diet_id": templeteidd, "p_user_id": puseridd});
//   }

//   Future<Response> chatAudioHistoryDietitian({int? page}) async {
//     return apiClient.postData(ApiConstants.dietitianAudioChat, {'page': page});
//   }

//   Future<Response> myDiet() async {
//     return apiClient.postData(ApiConstants.my_diet, {});
//   }

//   Future<Response> userspeciallmyDiet() async {
//     return apiClient.postData(ApiConstants.userspecialdiets, {});
//   }

// //
//   Future<Response> weeklydeits() async {
//     return apiClient.postData(ApiConstants.weeklyydietttnew, {});
//   }

// //
//   Future<Response> specialdietssss() async {
//     return apiClient.postData(ApiConstants.specialdeiets, {});
//   }

//   Future<Response> transactionHistory({int? page}) async {
//     return apiClient.postData(ApiConstants.transactionHistory, {'page': page});
//   }
}
