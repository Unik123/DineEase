import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/restro/table.dart';

class TableRepo {
  final _apiServices = NetworkApiServices();

  Future<List<Table>> fetchTables() async {
    try {
      final response =
          await _apiServices.getApi(AppUrl.tables) as List<dynamic>;

      if (response.isNotEmpty) {
        return response.map((value) => Table.fromJson(value)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> addTable(String name, String capacity) async {
    try {
      await _apiServices.postApi(
        {
          'number': name,
          'seats': capacity,
          'is_occupied': false,
        },
        AppUrl.tables,
      );
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> editTable(String id, String name, String capacity) async {
    try {
      await _apiServices.patchApi(
        {
          'number': name.toString(),
          'seats': capacity.toString(),
        },
        '${AppUrl.tables}$id/',
      );
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> deleteTable(String id) async {
    try {
      await _apiServices.deleteApi('${AppUrl.tables}$id/');
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> changeTableStatus(String id, bool isOccupied) async {
    try {
      await _apiServices.patchApi(
        {
          'is_occupied': isOccupied,
        },
        '${AppUrl.tables}$id/',
      );
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
