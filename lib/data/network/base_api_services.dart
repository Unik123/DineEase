abstract class BaseApiServices {
  Future<dynamic> getApi(String url, {Map<String, String>? headers});
  Future<dynamic> postApi(dynamic data, String url,
      {Map<String, String>? headers});
  Future<dynamic> patchApi(dynamic data, String url,
      {Map<String, String>? headers});
  Future<dynamic> putApi(dynamic data, String url,
      {Map<String, String>? headers});
  Future<dynamic> deleteApi(String url,
      {Map<String, dynamic>? params, Map<String, String>? headers});
}
