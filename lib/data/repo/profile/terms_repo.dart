import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/profile/terms_condition.dart';

class TermsRepo {
  final _apiServices = NetworkApiServices();

  Future<List<Terms>> fetchterms() async {
    try {
      final response =
          await _apiServices.getApi(AppUrl.termsUrl) as List<dynamic>;

      if (response.isNotEmpty) {
        return response.map((value) => Terms.fromJson(value)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
