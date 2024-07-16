import 'package:dineease/model/auth/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveViewModel extends ChangeNotifier {
  final Box _userBox = Hive.box('userBox');

  User? getCurrentUser() {
    final user = _userBox.get('currentUser');
    return user;
  }

  String? getRefreshToken() {
    final token = _userBox.get("refreshToken");
    return token;
  }

  Future<void> saveNewRefreshToken(String token) async {
    await _userBox.put("refreshToken", token);
    notifyListeners();
  }

  Future<void> saveUser(User user) async {
    await _userBox.put('currentUser', user);
    await _userBox.put("refreshToken", user.refreshToken);
    notifyListeners();
  }

  Future<void> logoutUser() async {
    await _userBox.clear();
    await _userBox.delete('currentUser');
    await _userBox.delete('refreshToken');

    notifyListeners();
  }

  @override
  void dispose() {
    _userBox.clear();
    super.dispose();
  }
}
