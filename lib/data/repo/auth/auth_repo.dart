import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/auth/user.dart';
import 'package:dineease/view_model/hive_vm.dart';

class AuthRepo {
  final NetworkApiServices _apiServices = NetworkApiServices();
  final HiveViewModel _hiveViewModel = HiveViewModel();

  Future<User?> login(String username, String password) async {
    final response = await _apiServices.postApi(
      {'username': username, 'password': password},
      AppUrl.loginUrl,
      headers: {'Content-Type': 'application/json'},
    );

    if (response is Map<String, dynamic> &&
        response.containsKey('access') &&
        response.containsKey('refresh') &&
        response.containsKey('user')) {
      if (response['user']['is_active'] == false) {
        throw Exception('Verify your email to log in.');
      } else {
        final user = User.fromJson(response);
        _hiveViewModel.saveUser(user);
        return user;
      }
    } else if (response is Map<String, dynamic> &&
        response.containsKey('non_field_errors')) {
      throw Exception(response['non_field_errors'][0]);
    }
    return null;
  }

  Future<bool> register(
    String firstName,
    String lastName,
    String role,
    String email,
    int contact,
    String address,
    String password,
  ) async {
    try {
      final response = await _apiServices.postApi(
        {
          "first_name": firstName,
          "last_name": lastName,
          "username": email,
          "role": role,
          "email": email,
          "contact": contact,
          "address": address,
          "password": password,
        },
        AppUrl.register,
        headers: {'Content-Type': 'application/json'},
      );

      if (response is Map<String, dynamic> &&
          response.containsKey('first_name') &&
          response.containsKey('last_name') &&
          response.containsKey('username')) {
        // final user = User.fromJson(response);
        // _hiveViewModel.saveUser(user);
        return true;
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw e is FetchDataException
          ? e
          : Exception('Registration failed due to an unexpected error. $e');
    }
  }

  Future<void> logout() async {
    await _hiveViewModel.logoutUser();
    try {
      await _apiServices.postApi(
        {},
        AppUrl.logoutUrl,
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      rethrow;
    }
  }
}
