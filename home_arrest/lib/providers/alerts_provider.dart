import 'package:flutter/material.dart';

import '../data/model/alerts_model.dart';
import '../data/repositories/alerts_repo.dart';

class ALertsProvider extends ChangeNotifier {
  final AlertsRepo alertsRepo;

  ALertsProvider({required this.alertsRepo});

  List<AlertsModel> _alerts = [];

  List<AlertsModel> get alerts => _alerts;

  Future<void> getALertsListing() async {
    try {
      await alertsRepo.getAlertsLisiting().then((responce) {
        if (responce.statusCode == 200) {
          // _alerts = List.from(value.body).map((e) => AlertsModel.fromJson(e)).toList();
          notifyListeners();
        }
      });
    } catch (e) {}
  }
}
