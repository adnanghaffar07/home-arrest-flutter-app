import 'package:get/get.dart';
import 'package:home_arrest/data/repositories/alerts_repo.dart';
import 'package:home_arrest/data/repositories/client_repo.dart';
import 'package:home_arrest/data/repositories/splash_repo.dart';
import 'package:home_arrest/data/repositories/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api_constants.dart';
import '../client/api_client.dart';
import '../repositories/auth_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: ApiConstants.baseUrl, sharedPreferences: sharedPreferences));

  // Repositories
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => ClientRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => SplashRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => UserRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => AlertsRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
}
