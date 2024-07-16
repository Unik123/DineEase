import 'package:dineease/data/repo/restro/dashboard_repo.dart';
import 'package:dineease/model/restro/dashboard.dart';
import 'package:flutter/material.dart';

class DashboardViewModel extends ChangeNotifier {
  final DashboardRepo _dashboardRepo = DashboardRepo();

  Dashboard? dashboard;
  bool isLoading = false;

  Future<void> fetchDashboardData() async {
    isLoading = true;
    dashboard = await _dashboardRepo.fetchDashboards();

    isLoading = false;
    notifyListeners();
  }
}