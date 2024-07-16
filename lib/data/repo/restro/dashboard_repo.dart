import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/restro/dashboard.dart';

class DashboardRepo {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<Dashboard> fetchDashboards() async {
    try {
      final response = await _apiServices.getApi(AppUrl.dashboard);

      return Dashboard.fromJson(response);
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
