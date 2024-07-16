import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/profile/profile.dart';

class ProfileRepo {
  final _apiServices = NetworkApiServices();

  Future<Profile> fetchProfile() async {
    try {
      final response = await _apiServices.getApi(AppUrl.profile);

      if (response.isNotEmpty) {
        return Profile.fromJson(response);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      await _apiServices.putApi(
        profile.toJson(),
        AppUrl.profile,
      );
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
