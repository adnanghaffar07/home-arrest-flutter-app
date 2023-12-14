import 'package:flutter/material.dart';
import 'package:home_arrest/constants/image_constants.dart';
import 'package:home_arrest/data/model/base/dashboard_model.dart';

class DashboardProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  final List<DashboardModel> _bottomItems = [
    DashboardModel(title: 'Home', icon: ImagesConstants.home, isSelected: true),
    DashboardModel(title: 'House Arrest', icon: ImagesConstants.houseArrest),
    // DashboardModel(title: 'Bail Bond', icon: ImagesConstants.bailBond),
    DashboardModel(title: 'Add Client', icon: ImagesConstants.addOffendor),
    DashboardModel(title: 'Alerts', icon: ImagesConstants.alerts),
  ];

  int get selectedIndex => _selectedIndex;
  List<DashboardModel> get bottomItems => _bottomItems;

  void changeIndex(int index) {
    _selectedIndex = index;
    for (var element in _bottomItems) {
      element.isSelected = false;
    }
    _bottomItems[index].isSelected = true;
    notifyListeners();
  }
}
