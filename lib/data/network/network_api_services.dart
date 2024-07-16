import 'dart:async';
import 'dart:convert';
import 'package:dineease/data/network/app_exception.dart';
import 'package:dineease/data/network/app_url.dart';
import 'package:dineease/data/network/base_api_services.dart';
import 'package:dineease/model/auth/user.dart';
import 'package:dineease/view_model/hive_vm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  final HiveViewModel _hiveViewModel = HiveViewModel();

  Future<Map<String, String>> getDefaultHeaders(
      {bool includeAuth = true}) async {
    if (!includeAuth) {
      return {'Content-Type': 'application/json'};
    }

    User? currentUser = _hiveViewModel.getCurrentUser();
    String? accessToken = currentUser?.accessToken;
    return accessToken != null
        ? {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'
          }
        : {'Content-Type': 'application/json'};
  }

  Future<bool> _refreshToken() async {
    try {
      String? refreshToken = _hiveViewModel.getRefreshToken();
      User? currentUser = _hiveViewModel.getCurrentUser();
      if (refreshToken == null) return false;
      var response = await http.post(Uri.parse(AppUrl.refreshToken),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'refresh': refreshToken}));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        currentUser!.accessToken = data['access'];
        currentUser.refreshToken = data['refresh'];
        _hiveViewModel.saveUser(currentUser);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Token refresh error: $e");
      return false;
    }
  }

  Future<http.Response> _sendRequest(
      Future<http.Response> Function() requestFunc) async {
    var response = await requestFunc();
    if (response.statusCode == 401 || response.statusCode == 403) {
      var refreshed = await _refreshToken();
      if (refreshed) return await requestFunc();
      // If token refresh fails, clear hive box
      _hiveViewModel.logoutUser();
      throw UnauthorizedException("Session expired. Please log in again.");
    }
    return response;
  }

  dynamic _returnResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 203) {
      return json.decode(response.body);
    }
    if (response.statusCode == 204) {
      return json.decode('{"message": "Deleted Successfully"}');
    }
    if (response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      throw FetchDataException(
          'Error occurred with StatusCode: ${response.statusCode}');
    }
  }

  @override
  Future<dynamic> getApi(String url, {Map<String, String>? headers}) async {
    headers ??= await getDefaultHeaders();
    http.Response response = await _sendRequest(
      () => http.get(Uri.parse(url), headers: headers),
    );
    return _returnResponse(response);
  }

  @override
  Future<dynamic> postApi(dynamic data, String url,
      {Map<String, String>? headers}) async {
    headers ??= await getDefaultHeaders();
    http.Response response = await _sendRequest(
      () =>
          http.post(Uri.parse(url), body: json.encode(data), headers: headers),
    );

    // print(response.body);
    return _returnResponse(response);
  }

  @override
  Future<dynamic> patchApi(dynamic data, String url,
      {Map<String, String>? headers}) async {
    headers ??= await getDefaultHeaders();
    http.Response response = await _sendRequest(
      () =>
          http.patch(Uri.parse(url), body: json.encode(data), headers: headers),
    );
    return _returnResponse(response);
  }

  @override
  Future<dynamic> putApi(dynamic data, String url,
      {Map<String, String>? headers}) async {
    headers ??= await getDefaultHeaders();
    http.Response response = await _sendRequest(
      () => http.put(Uri.parse(url), body: json.encode(data), headers: headers),
    );
    return _returnResponse(response);
  }

  @override
  Future<dynamic> deleteApi(String url,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    headers ??= await getDefaultHeaders();
    headers['Content-Type'] =
        'application/json'; //Content-Type as application/json

    var uri = Uri.parse(url);
    var request = http.Request('DELETE', uri)
      ..headers.addAll(headers)
      ..body = json.encode(params); // Convert params Map to JSON String

    http.Response response = await _sendRequest(
      () async {
        http.StreamedResponse streamedResponse =
            await http.Client().send(request);
        return http.Response.fromStream(streamedResponse);
      },
    );
    return _returnResponse(response);
  }
}
