import 'package:flutter/material.dart';
import 'package:home_arrest/data/model/client_history_mode.dart';

import '../constants/image_constants.dart';
import '../data/model/client.dart';
import '../data/model/client_type.dart';

class ClientProvider extends ChangeNotifier {
  final List<BottomSheetSelectionModel> _clientTypes = [
    BottomSheetSelectionModel(title: "House Arrest Client", icon: ImagesConstants.houseArrestClient),
    BottomSheetSelectionModel(title: "Bail Bond Client", icon: ImagesConstants.bailBondClient),
    BottomSheetSelectionModel(title: "Spotlight Client", icon: ImagesConstants.spotlightClient),
    BottomSheetSelectionModel(title: "Medical Client", icon: ImagesConstants.medicalClient),
    BottomSheetSelectionModel(title: "My Day N Court", icon: ImagesConstants.daynCourt)
  ];

  final List<BottomSheetSelectionModel> _chekInList = [
    BottomSheetSelectionModel(title: "None", icon: ImagesConstants.none),
    BottomSheetSelectionModel(title: "Present", icon: ImagesConstants.present),
    BottomSheetSelectionModel(title: "Random", icon: ImagesConstants.random),
  ];

  final List<BottomSheetSelectionModel> _monitorLevelList = [
    BottomSheetSelectionModel(title: "Low", icon: ImagesConstants.low),
    BottomSheetSelectionModel(title: "Medium", icon: ImagesConstants.medium),
    BottomSheetSelectionModel(title: "High", icon: ImagesConstants.high),
  ];

  final List<BottomSheetSelectionModel> _gendersList = [
    BottomSheetSelectionModel(title: "Male"),
    BottomSheetSelectionModel(title: "Female"),
    BottomSheetSelectionModel(title: "None"),
  ];

  final List<ClientModel> _clients = [
    ClientModel(name: "Allison Webber", associatedUsers: ["Adnan Ghaffar"]),
    ClientModel(name: "Bart Copper"),
    ClientModel(name: "Carlos Marin"),
    ClientModel(name: "Gateway Group"),
    ClientModel(name: "Jin White"),
    ClientModel(name: "Jeff Webber"),
  ];

  final List<ClientHistoryModel> _clientHisotry = [
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "1234 Main St, Los Angeles, CA 90012"),
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "30 N Gould St Ste 7596, Sheridan, WY,82801."),
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "1234 Main St, Los Angeles, CA 90012"),
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "30 N Gould St Ste 7596, Sheridan, WY,82801."),
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "1234 Main St, Los Angeles, CA 90012"),
  ];

  List<BottomSheetSelectionModel> get clientTypes => _clientTypes;
  List<BottomSheetSelectionModel> get chekInList => _chekInList;
  List<BottomSheetSelectionModel> get monitorLevelList => _monitorLevelList;
  List<BottomSheetSelectionModel> get gendersList => _gendersList;
  List<ClientModel> get clients => _clients;
  List<ClientHistoryModel> get clientHisotry => _clientHisotry;

  String selectClientType(int index) {
    for (var element in _clientTypes) {
      element.isSelected = false;
    }
    _clientTypes[index].isSelected = true;
    notifyListeners();
    return _clientTypes[index].title;
  }

  String setMonitorLevel(int index) {
    for (var element in _monitorLevelList) {
      element.isSelected = false;
    }
    _monitorLevelList[index].isSelected = true;
    notifyListeners();
    return _monitorLevelList[index].title;
  }

  String setCheckIn(int index) {
    for (var element in _chekInList) {
      element.isSelected = false;
    }
    _chekInList[index].isSelected = true;
    notifyListeners();
    return _chekInList[index].title;
  }

  String selectGender(int index) {
    for (var element in _gendersList) {
      element.isSelected = false;
    }
    _gendersList[index].isSelected = true;
    notifyListeners();
    return _gendersList[index].title;
  }
}
