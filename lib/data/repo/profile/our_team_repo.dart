import 'dart:io';

import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/network_api_services.dart';
import 'package:dineease/model/profile/team.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class OurTeamRepo {
  final _apiServices = NetworkApiServices();

  Future<List<Team>> fetchTeams() async {
    try {
      final response =
          await _apiServices.getApi(AppUrl.ourteam) as List<dynamic>;

      if (response.isNotEmpty) {
        return response.map((value) => Team.fromJson(value)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }

  Future<void> updateMember(
      String id, String name, File image, String role) async {
    var uri = Uri.parse('${AppUrl.ourteam}$id/');
    var request = http.MultipartRequest('PUT', uri);

    request.fields['name'] = name;
    request.fields['role'] = role;

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
      print('Item Edited successfully');
    } else {
      print('Failed to upload item: ${response.statusCode}');
    }
  }

  Future<void> addMember(String name, File image, String role) async {
    var uri = Uri.parse(AppUrl.ourteam);
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['role'] = role;

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

  Future<void> deleteMember(String id) async {
    try {
      await _apiServices.deleteApi('${AppUrl.ourteam}$id/');
    } catch (e) {
      throw e is FetchDataException ? e : Exception('Unexpected error. $e');
    }
  }
}
