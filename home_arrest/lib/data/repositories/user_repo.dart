import 'dart:developer';

import 'package:get/get.dart';
import 'package:home_arrest/constants/api_constants.dart';
import 'package:home_arrest/data/client/api_client.dart';
import 'package:home_arrest/data/model/admin_user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> updateUserProfile(AdminUserModel userModel) async {
    return await apiClient.postData(ApiConstants.updateAdminProfile, userModel.toJson());
  }

  Future<Response> addUserPic(XFile data) async {
    inspect(data);
    return await apiClient.postMultipartData(ApiConstants.addAdminProfilePic, {'user_id': '1'}, [MultipartBody('image', data)]);
  }

  Future<Response> getUserDetails() async {
    return await apiClient.getData(ApiConstants.getAdminProfileDeatils);
  }

  Future<Response> addUserSignature(XFile data) async {
    inspect(data);
    return await apiClient.postMultipartData(ApiConstants.addUserSignature, {}, [MultipartBody('image', data)]);
  }
}
