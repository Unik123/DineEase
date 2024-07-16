import 'package:dineease/data/repo/profile/privacy_repo.dart';
import 'package:dineease/model/profile/privacy.dart';
import 'package:flutter/material.dart';

class PrivacyViewModel extends ChangeNotifier {
  final PrivacyRepo _privacyRepo = PrivacyRepo();

  List<Privacy> infos = [];
  String errorMessage = '';

  Future<void> fetchItems() async {
    try {
      infos = await _privacyRepo.fetchInfo();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
