import 'package:flutter/material.dart';

import '../data/model/base/radio_model.dart';

class ClientProvider extends ChangeNotifier {
  int _selectedTabIndex = 0;
  final List<String> _clientTypes = [
    "House Arrest Client",
    "Bail Bond Client",
    "Spotlight Client",
    "Medical Client",
    "My Day N Court",
  ];
  final List<RadioModel> _chekInList = [
    RadioModel(title: "None"),
    RadioModel(title: "Present"),
    RadioModel(title: "Random"),
  ];
  final List<RadioModel> _monitorLevelList = [
    RadioModel(title: "Low"),
    RadioModel(title: "Medium"),
    RadioModel(title: "High"),
  ];

  int get selectedTabIndex => _selectedTabIndex;
  List<String> get clientTypes => _clientTypes;
  List<RadioModel> get chekInList => _chekInList;
  List<RadioModel> get monitorLevelList => _monitorLevelList;

  void changeTab(int val) {
    _selectedTabIndex = val;
    notifyListeners();
  }

  void changeCheckInSelection(String val) {
    for (var element in _chekInList) {
      element.isSelected = false;
    }
    _chekInList[_chekInList.indexWhere((element) => element.title == val)].isSelected = true;
    notifyListeners();
  }

  void changeMonitorLevelSelection(String val) {
    for (var element in _monitorLevelList) {
      element.isSelected = false;
    }
    _monitorLevelList[_monitorLevelList.indexWhere((element) => element.title == val)].isSelected = true;
    notifyListeners();
  }
}
