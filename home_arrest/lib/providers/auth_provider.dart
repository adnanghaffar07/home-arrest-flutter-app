// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_arrest/data/model/admin_user_model.dart';
import 'package:home_arrest/data/repositories/auth_repo.dart';
import 'package:home_arrest/utils/utils.dart';

import '../view/dashboard/dashboard_screen.dart';
import '../view/onboarding/sign_in/sign_in_screen.dart';

class AuthProvider extends ChangeNotifier {
  AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  bool _isLoginLoading = false;
  AdminUserModel? _admin;

  bool get isLoginLoading => _isLoginLoading;
  AdminUserModel? get admin => _admin;

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  void logout(BuildContext context) async {
    await authRepo.sharedPreferences.clear().then((value) {
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    });
  }

  Future<void> login(BuildContext context, {required String email, required String password}) async {
    _isLoginLoading = true;
    notifyListeners();
    try {
      await authRepo.login(email, password).then((responce) async {
        if (responce.body['status']) {
          await authRepo.saveUserData(AdminUserModel.fromJson(responce.body['details']));
          authRepo.saveUserToken(responce.body['token']).then((value) {
            if (value) {
              Navigator.pushNamedAndRemoveUntil(context, DashboardScreen.routeName, (route) => false);
            }
          });
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('login error catch: $e');
      Utils.showErrorToast(context, 'Login failed due to server error');
    } finally {
      _isLoginLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(BuildContext context, {required String email, required String password, required String number}) async {
    _isLoginLoading = true;
    notifyListeners();
    try {
      await authRepo.signUp(email, password, number).then((responce) {
        if (responce.body['status']) {
          authRepo.saveUserToken(responce.body['token']).then((value) {
            if (value) {
              Navigator.pushNamedAndRemoveUntil(context, DashboardScreen.routeName, (route) => false);
            }
          });
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('login error catch: $e');
      Utils.showErrorToast(context, 'Login failed due to server error');
    } finally {
      _isLoginLoading = false;
      notifyListeners();
    }
  }

  Future<void> changePassword(BuildContext context, {required String oldPass, newPass}) async {
    _isLoginLoading = true;
    notifyListeners();
    try {
      await authRepo.changePassword(oldPass, newPass).then((responce) {
        if (responce.body['status']) {
          authRepo.saveUserToken(responce.body['token']).then((value) {
            Utils.showToast(context, "Password changed successfully", backgroundColor: const Color(0xFF21356A), textColor: Colors.white);
            Navigator.pop(context);
          });
        } else {
          Utils.showErrorToast(context, responce.body['message']);
        }
      });
    } catch (e) {
      debugPrint('login error catch: $e');
      Utils.showErrorToast(context, 'Login failed due to server error');
    } finally {
      _isLoginLoading = false;
      notifyListeners();
    }
  }

  void getUserDetailsFromPref() async {
    var data = authRepo.getUserData();
    if (data.isNotEmpty) {
      _admin = AdminUserModel.fromJson(jsonDecode(data));
    }
  }
}
