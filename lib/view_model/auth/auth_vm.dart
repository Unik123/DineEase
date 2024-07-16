import 'package:dineease/data/repo/auth/auth_repo.dart';
import 'package:dineease/model/auth/user.dart';
import 'package:dineease/view_model/hive_vm.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final HiveViewModel _hiveViewModel = HiveViewModel();

  final AuthRepo _authRepo = AuthRepo();
  User? _currentUser;
  String? _errorMessage;
  bool _isLoading = false;

  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  User? get currentUser => _currentUser;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setCurrentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool get isLoggedIn => _currentUser != null;

  AuthViewModel() {
    getCurrentUser();
  }

  Future<bool> login(String username, String password) async {
    isLoading = true;
    _errorMessage = null;
    bool success = false;
    try {
      _currentUser = await _authRepo.login(username, password);
      _currentUser == null ? null : setCurrentUser(_currentUser);
      success = isLoggedIn ? true : false;
    } catch (e) {
      _errorMessage = e.toString().split("Exception: ")[1];
    } finally {
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
    return success;
  }

  Future<bool> register(
    String firstName,
    String lastName,
    String role,
    String email,
    int contact,
    String address,
    String password1,
    String password2,
  ) async {
    isLoading = true;
    _errorMessage = null;
    bool success = false;
    try {
      success = await _authRepo.register(
        firstName,
        lastName,
        role,
        email,
        contact,
        address,
        password1,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
    notifyListeners();
    return success;
  }

  Future<void> logout(BuildContext context) async {
    isLoading = true;
    try {
      await _authRepo.logout();
      _currentUser = null;
    } catch (e) {
      _errorMessage = 'Failed to log out. Please try again.';
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  void setNewData(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  void getCurrentUser() {
    _currentUser = _hiveViewModel.getCurrentUser();
    notifyListeners();
  }
}
