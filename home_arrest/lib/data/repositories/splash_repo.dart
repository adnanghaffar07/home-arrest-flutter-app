import 'package:home_arrest/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../client/api_client.dart';

class SplashRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.apiClient, required this.sharedPreferences});

  void initData() {
    apiClient.token = sharedPreferences.getString(AppConstants.token);
    apiClient.updateHeader(apiClient.token, 'en');
  }
}
