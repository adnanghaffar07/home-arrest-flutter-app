import 'package:flutter/material.dart';
import 'package:home_arrest/data/repositories/splash_repo.dart';

class SplashProvider extends ChangeNotifier {
  SplashRepo splashRepo;

  SplashProvider({required this.splashRepo});

  void initData() {
    splashRepo.initData();
  }
}
