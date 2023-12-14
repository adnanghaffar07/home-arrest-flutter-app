import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:home_arrest/constants/api_constants.dart';
import 'package:home_arrest/constants/app_constants.dart';
import 'package:home_arrest/data/client/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/admin_user_model.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(ApiConstants.login, {"email": email, "password": password});
  }

  Future<Response> signUp(String email, password, number) async {
    return await apiClient.postData(ApiConstants.signUp, {
      "email": email,
      "password": password,
      "phoneNumber": number,
      "firstName": "Adnan",
      "lastName": "Ghaffar",
      "gender": "male",
      "role": 1,
    });
  }

  Future<Response> changePassword(String oldPass, newPass) async {
    return await apiClient.postData(ApiConstants.changePassword, {"oldPassword": oldPass, "newPassword": newPass});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token, 'en');
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<bool> saveUserData(AdminUserModel obj) async {
    return await sharedPreferences.setString(AppConstants.user, jsonEncode(obj.toJson()));
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  String getUserData() {
    return sharedPreferences.getString(AppConstants.user) ?? "";
  }

  bool isLoggedIn() {
    log('token: ${sharedPreferences.getString(AppConstants.token) ?? 'empty'}');
    return sharedPreferences.containsKey(AppConstants.token);
  }
}
