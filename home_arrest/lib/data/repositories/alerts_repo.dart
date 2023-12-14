import 'package:get/get.dart';
import 'package:home_arrest/constants/api_constants.dart';
import 'package:home_arrest/data/client/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AlertsRepo({required this.apiClient, required this.sharedPreferences});

  // Future<Response> addOffender(OffendorModel offenderModel) async {
  //   return await apiClient.postData(ApiConstants.addOffender, offenderModel.toJson());
  // }

  Future<Response> getAlertsLisiting() async {
    return await apiClient.getData(ApiConstants.getALertsListing);
  }
}
