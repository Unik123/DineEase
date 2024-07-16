import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/restro/employee.dart';

class EmployeeRepo {
  final _apiServices = NetworkApiServices();

  Future<List<Employee>> fetchEmployee() async {
    try {
      final response =
          await _apiServices.getApi(AppUrl.employee) as List<dynamic>;
      if (response.isNotEmpty) {
        return response.map((value) => Employee.fromJson(value)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> changeRole(String id, String role, bool isActive) async {
    try {
      await _apiServices.patchApi(
        {
          'role': role,
          'is_active': isActive,
        },
        '${AppUrl.employee}$id/',
      );
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
