import 'dart:convert';
import 'package:aci_app/constants/app_constant.dart';
import 'package:aci_app/utils/apis/api_checker.dart';
import 'package:aci_app/utils/models/errer_repsonse.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as Http;

import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetxService {
  String? appBaseUrl = AppConstants.baseUrl;
  final SharedPreferences sharedPreferences;
  final String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  String? token;
  //String? userID;
  Map<String, String>? _mainHeaders;

  ApiClient({
    this.appBaseUrl,
    required this.sharedPreferences,
  }) {
    //  print(" token.............................................$token");

    _mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${sharedPreferences.getString(AppConstants.token)}',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // void userId(String userID) {
  //   _mainHeaders = {};
  // }

  Future<Response> postData(
    String uri,
    dynamic body,
  ) async {
    if (await ApiChecker.isVpnActive()) {
      return const Response(statusCode: -1, statusText: 'you are using vpn');
    }
    {
      try {
        if (Foundation.kDebugMode) {
          print('====> GetX Base URL: $appBaseUrl');
          print('====> GetX Call: $uri');
          print('====> GetX Body: $body');
          print(
              'Token::::::::::${sharedPreferences.getString(AppConstants.token)}');
        }
        print('====> GetX Basebodyy: $body');
        Http.Response response0 = await Http.post(
          Uri.parse(appBaseUrl! + uri),
          body: jsonEncode(body),
          headers: _mainHeaders,
        ).timeout(Duration(seconds: timeoutInSeconds));
        print("++++++++++++>>>=====");
        Response response = handleResponse(response0, uri);

        if (Foundation.kDebugMode) {
          print(
              '====> API Response: [${response.statusCode}] $uri\n${response.body}');
        }
        print('====>  respnosee : ${response.body}');
        return response;
      } catch (e) {
        return Response(statusCode: 1, statusText: noInternetMessage);
      }
    }
  }

  Future<Response> postDataMap(
    String uri,
    dynamic body,
  ) async {
    if (await ApiChecker.isVpnActive()) {
      return const Response(statusCode: -1, statusText: 'you are using vpn');
    }
    {
      try {
        if (Foundation.kDebugMode) {
          print('====> GetX Base URL: $appBaseUrl');
          print('====> GetX Call: $uri');
          print('====> GetX Body: $body');
        }
        print('====> GetX Basebodyy: $body');
        Http.Response response0 = await Http.post(
          Uri.parse(appBaseUrl! + uri),
          body: body,
          headers: _mainHeaders,
        ).timeout(Duration(seconds: timeoutInSeconds));
        print("++++++++++++>>>=====");
        Response response = handleResponse(response0, uri);

        if (Foundation.kDebugMode) {
          print(
              '====> API Response: [${response.statusCode}] $uri\n${response.body}');
        }
        print('====>  respnosee : ${response.body}');
        return response;
      } catch (e) {
        return Response(statusCode: 1, statusText: noInternetMessage);
      }
    }
  }

  Future<Response> getData(
    String uri,
  ) async {
    if (await ApiChecker.isVpnActive()) {
      return const Response(statusCode: -1, statusText: 'you are using vpn');
    } else {
      try {
        debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
        print(' Majannaha headers $_mainHeaders');
        print(' url $uri');
        Http.Response response = await Http.get(
          Uri.parse(appBaseUrl! + uri),
          headers: _mainHeaders,
        ).timeout(Duration(seconds: timeoutInSeconds));
        print(' Majannah headers $_mainHeaders');
        debugPrint('====> API  Fund : - response data v${response.body}');
        return handleResponse(response, uri);
      } catch (e) {
        return Response(statusCode: 1, statusText: noInternetMessage);
      }
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {}
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: errorResponse.errors[0].message);
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: response0.body['message']);
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }
    debugPrint(
        '====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    return response0;
  }
}
