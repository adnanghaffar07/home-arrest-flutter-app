import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:home_arrest/data/model/client_history_mode.dart';
import 'package:home_arrest/data/model/offender_model.dart';
import 'package:home_arrest/data/repositories/client_repo.dart';
import 'package:home_arrest/view/dashboard/dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/image_constants.dart';
import '../data/model/client_type.dart';
import '../utils/utils.dart';

class ClientProvider extends ChangeNotifier {
  ClientRepo clientRepo;

  ClientProvider({required this.clientRepo});

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

  final List<ClientHistoryModel> _clientHisotry = [
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "1234 Main St, Los Angeles, CA 90012"),
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "30 N Gould St Ste 7596, Sheridan, WY,82801."),
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "1234 Main St, Los Angeles, CA 90012"),
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "30 N Gould St Ste 7596, Sheridan, WY,82801."),
    ClientHistoryModel(dateTime: "24 March, 12:00 PM", address: "1234 Main St, Los Angeles, CA 90012"),
  ];

  List<OffendorModel> _offenders = [];
  XFile? _pickedFile;
  Uint8List? _rawFile;
  bool _isLoading = false;

  List<BottomSheetSelectionModel> get clientTypes => _clientTypes;
  List<BottomSheetSelectionModel> get chekInList => _chekInList;
  List<BottomSheetSelectionModel> get monitorLevelList => _monitorLevelList;
  List<BottomSheetSelectionModel> get gendersList => _gendersList;
  List<ClientHistoryModel> get clientHisotry => _clientHisotry;
  List<OffendorModel> get offenders => _offenders;
  XFile? get pickedFile => _pickedFile;
  Uint8List? get rawFile => _rawFile;
  bool get isLoading => _isLoading;

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

  void setSelectedOffendor(int index) {
    for (var element in _offenders) {
      element.isSelected = false;
    }
    _offenders[index].isSelected = true;
    notifyListeners();
  }

  void clearOffendorImage() {
    _pickedFile = null;
    _rawFile = null;
    notifyListeners();
  }

  Future<void> pickOffendorImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      _pickedFile = _pickedFile;
      _rawFile = await _pickedFile!.readAsBytes();
    }
    notifyListeners();
  }

/////////////////////////////////////////////////// API ////////////////////////////////////////////////

  Future<void> getOffendorsListing(BuildContext context) async {
    _isLoading = true;
    _offenders.clear();
    notifyListeners();
    try {
      await clientRepo.getOffenders().then((responce) {
        if (responce.body['status']) {
          _offenders = List.from(responce.body['details']).map((e) => OffendorModel.fromJson(e)).toList();
          inspect(_offenders);
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('addOfender catch Error: $e');
      Utils.showErrorToast(context, 'Failed to get clients due to server error!');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addOffendor(OffendorModel offendor, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await clientRepo.addOffender(offendor).then((responce) async {
        if (responce.body['status']) {
          await addOffendorProfilePic(responce.body['details']['uniqueId'], _pickedFile!, context, responce.body['message']);
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('addOfender catch Error: $e');
      Utils.showErrorToast(context, 'Failed due to server error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addOffendorProfilePic(String id, XFile image, BuildContext context, String message) async {
    try {
      await clientRepo.addOffenderProfilePic(id, image).then((responce) {
        if (responce.body['status']) {
          Utils.showToast(context, message);
          Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('addOfender catch Error: $e');
      Utils.showErrorToast(context, 'Failed due to server error');
    }
  }
}
