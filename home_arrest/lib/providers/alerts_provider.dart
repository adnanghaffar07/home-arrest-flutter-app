import 'dart:developer';

import 'package:flutter/material.dart';

import '../data/model/alerts_model.dart';
import '../data/repositories/alerts_repo.dart';

class ALertsProvider extends ChangeNotifier {
  final AlertsRepo alertsRepo;

  ALertsProvider({required this.alertsRepo});

  List<AlertsModel> _alerts = [];
  bool _isLoading = false;

  List<AlertsModel> get alerts => _alerts;
  bool get isLoading => _isLoading;

  Future<void> getALertsListing() async {
    _isLoading = true;
    _alerts.clear();
    notifyListeners();
    try {
      await alertsRepo.getAlertsLisiting().then((responce) {
        if (responce.statusCode == 200 && responce.body != null && responce.body['status']) {
          _alerts = List.from(responce.body['alerts']).map((e) => AlertsModel.fromJson(e)).toList();
        }
      });
    } catch (e) {
      log('Error in getALertsListing: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
