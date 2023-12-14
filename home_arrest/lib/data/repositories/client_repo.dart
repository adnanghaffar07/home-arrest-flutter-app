import 'package:get/get.dart';
import 'package:home_arrest/constants/api_constants.dart';
import 'package:home_arrest/data/client/api_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/offender_model.dart';

class ClientRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ClientRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> addOffender(OffendorModel offenderModel) async {
    return await apiClient.postData(ApiConstants.addOffender, offenderModel.toJson());
  }

  Future<Response> addOffenderProfilePic(String offendorId, XFile data) async {
    Map<String, String> body = {};
    body.addAll(<String, String>{'uniqueId': offendorId});
    return await apiClient.postMultipartData(ApiConstants.addOffendorProfilePic, body, [MultipartBody('image', data)]);
  }

  Future<Response> getOffenders() async {
    return await apiClient.getData(ApiConstants.getOffenders);
  }
}
