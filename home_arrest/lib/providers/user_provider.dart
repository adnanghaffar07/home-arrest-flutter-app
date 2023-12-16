import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:home_arrest/data/repositories/user_repo.dart';
import 'package:image_picker/image_picker.dart';

import '../data/model/admin_user_model.dart';
import '../data/model/client_type.dart';
import '../utils/utils.dart';

class UserProvider extends ChangeNotifier {
  UserRepo userRepo;

  UserProvider({required this.userRepo});

  final List<BottomSheetSelectionModel> _gendersList = [
    BottomSheetSelectionModel(title: "Male"),
    BottomSheetSelectionModel(title: "Female"),
    BottomSheetSelectionModel(title: "None"),
  ];

  AdminUserModel? _user;
  XFile? _pickedFile;
  Uint8List? _rawFile;
  bool _isLoading = false;

  List<BottomSheetSelectionModel> get gendersList => _gendersList;
  AdminUserModel? get user => _user;
  XFile? get pickedFile => _pickedFile;
  Uint8List? get rawFile => _rawFile;
  bool get isLoading => _isLoading;

  String selectGender(int index) {
    for (var element in _gendersList) {
      element.isSelected = false;
    }
    _gendersList[index].isSelected = true;
    notifyListeners();
    return _gendersList[index].title;
  }

  void clearUserImage() {
    _pickedFile = null;
    _rawFile = null;
    notifyListeners();
  }

  Future<void> pickUserImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      _pickedFile = _pickedFile;
      _rawFile = await _pickedFile!.readAsBytes();
    }
    notifyListeners();
  }

/////////////////////////////////////////////// API ////////////////////////////////

  Future<void> getUserDetails(BuildContext context) async {
    _isLoading = true;
    _user = null;
    notifyListeners();
    try {
      await userRepo.getUserDetails().then((responce) {
        if (responce.body['status']) {
          _user = AdminUserModel.fromJson(responce.body['details']);
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('getUserDetails catch Error: $e');
      Utils.showErrorToast(context, 'Failed to get User Profile');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(AdminUserModel user, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await userRepo.updateUserProfile(user).then((responce) async {
        if (responce.body['status']) {
          if (_pickedFile != null) {
            await updateUserPic(_pickedFile!, context, responce.body['message']);
          } else {
            Utils.showToast(context, responce.body['message'], backgroundColor: const Color(0xFF21356A), textColor: Colors.white);
            Navigator.of(context).pop(true);
          }
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('updateUser catch Error: $e');
      Utils.showErrorToast(context, 'Failed due to server error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserPic(XFile image, BuildContext context, String message) async {
    try {
      await userRepo.addUserPic(image).then((responce) {
        if (responce.body['status']) {
          Utils.showToast(context, message, backgroundColor: const Color(0xFF21356A), textColor: Colors.white);
          Navigator.of(context).pop(true);
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('updateUserPic catch Error: $e');
      Utils.showErrorToast(context, 'Failed due to server error');
    }
  }

  Future<void> updateUserSignature(XFile image, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await userRepo.addUserSignature(image).then((responce) {
        if (responce.body['status']) {
          Utils.showToast(context, responce.body['message'], backgroundColor: const Color(0xFF21356A), textColor: Colors.white);
          Navigator.of(context).pop(true);
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('updateUserSignature catch Error: $e');
      Utils.showErrorToast(context, 'Failed due to server error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
