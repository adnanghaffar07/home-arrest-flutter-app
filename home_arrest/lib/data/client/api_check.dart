import 'dart:developer';

import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    log("Api response status code is : ${response.statusCode}");
    if (response.statusCode == 401) {
    } else if (response.statusCode == 500) {
    } else {}
  }
}
