import 'package:dineease/data/repo/restro/banner_repo.dart';
import 'package:dineease/model/restro/banner.dart';
import 'package:flutter/material.dart' show ChangeNotifier;

class BannerViewModel extends ChangeNotifier {
  final BannerRepo _tableRepo = BannerRepo();

  List<Banner> banners = [];
  String errorMessage = '';

  Future<void> fetchBanners() async {
    try {
      banners = await _tableRepo.fetchBanners();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
