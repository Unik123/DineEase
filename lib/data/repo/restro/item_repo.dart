import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/restro/item.dart';

class ItemRepo {
  final _apiServices = NetworkApiServices();

  Future<List<Item>> fetchItems() async {
    try {
      final response = await _apiServices.getApi(AppUrl.items) as List<dynamic>;

      if (response.isNotEmpty) {
        return response.map((value) => Item.fromJson(value)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> addItem(
    String name,
    String price,
    String description,
    File image,
    String category,
  ) async {
    var uri = Uri.parse(AppUrl.items);
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['price'] = price;
    request.fields['description'] = description;
    request.fields['department'] = category;  

    var fileStream = http.ByteStream(image.openRead());
    var fileLength = await image.length();

    var multipartFile = http.MultipartFile(
      'image',
      fileStream,
      fileLength,
      filename: basename(image.path),
    );

    request.files.add(multipartFile);

    // Send request
    var response = await request.send();
    if (response.statusCode == 201) {
      print('Item uploaded successfully');
    } else {
      print('Failed to upload item: ${response.statusCode}');
    }
  }

  Future<void> editItem(
    String id,
    String name,
    String price,
    String description,
    File image,
    String category,
  ) async {
    var uri = Uri.parse('${AppUrl.items}$id/');
    var request = http.MultipartRequest('PUT', uri);

    request.fields['name'] = name;
    request.fields['price'] = price;
    request.fields['description'] = description;
    request.fields['department'] = category;

    var fileStream = http.ByteStream(image.openRead());
    var fileLength = await image.length();

    var multipartFile = http.MultipartFile(
      'image',
      fileStream,
      fileLength,
      filename: basename(image.path),
    );

    request.files.add(multipartFile);

    // Send request
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Item updated successfully');
    } else {
      print('Failed to update item: ${response.statusCode}');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _apiServices.deleteApi('${AppUrl.items}$id/');
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
