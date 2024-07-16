import 'package:flutter/material.dart';

class ShowPasswordProvider extends ChangeNotifier {
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
}

class ConformPasswordProvider extends ChangeNotifier {
  bool _iscPasswordVisible = false;

  bool get iscPasswordVisible => _iscPasswordVisible;

  void togglePasswordVisibility() {
    _iscPasswordVisible = !_iscPasswordVisible;
    notifyListeners();
  }
}
