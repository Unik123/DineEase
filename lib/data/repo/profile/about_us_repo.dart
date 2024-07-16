import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/restro/restro_info.dart';

class AboutUsRepo {
  final _apiServices = NetworkApiServices();

  Future<List<RestroInfo>> fetchInfo() async {
    try {
      final response = await _apiServices.getApi(AppUrl.info) as List<dynamic>;

      if (response.isNotEmpty) {
        return response.map((value) => RestroInfo.fromJson(value)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> updateInfo(RestroInfo info) async {
    try {
      await _apiServices.patchApi(
        {
        "restaurant_address": info.address,
        "restaurant_contact": info.contact,
        "restaurant_description": info.description,
      },
        '${AppUrl.info}${info.id}/',
      );
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
