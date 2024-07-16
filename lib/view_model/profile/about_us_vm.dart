import 'package:dineease/data/repo/profile/about_us_repo.dart';
import 'package:dineease/model/restro/restro_info.dart';
import 'package:flutter/material.dart';

class AboutUsViewModel extends ChangeNotifier {
  final AboutUsRepo _aboutRepo = AboutUsRepo();

  List<RestroInfo> infos = [];
  String errorMessage = '';

  Future<void> fetchInfo() async {
    try {
      infos = await _aboutRepo.fetchInfo();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateInfo(RestroInfo info) async {
    try {
      await _aboutRepo.updateInfo(info);
      infos = [info];
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
