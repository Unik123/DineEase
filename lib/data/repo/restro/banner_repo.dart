import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/restro/banner.dart';

class BannerRepo {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<List<Banner>> fetchBanners() async {
    try {
      final response = await _apiServices.getApi(AppUrl.banners);

      if (response is List<dynamic>) {
        return response.map((order) => Banner.fromJson(order)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
