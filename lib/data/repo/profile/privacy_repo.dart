import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/profile/privacy.dart';

class PrivacyRepo {
  final _apiServices = NetworkApiServices();

  Future<List<Privacy>> fetchInfo() async {
    try {
      final response =
          await _apiServices.getApi(AppUrl.privacyUrl) as List<dynamic>;

      if (response.isNotEmpty) {
        return response.map((value) => Privacy.fromJson(value)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
