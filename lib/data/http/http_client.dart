import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future<http.Response> get({required String url});
  Future<http.Response> post({required String url, required String body});
  Future<http.Response> put({required String url, required String body});
  Future<http.Response> delete({required String url});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future<http.Response> get({required String url}) async {
    final response = await client.get(Uri.parse(url));
    return response;
  }

  @override
  Future<http.Response> post({required String url, required String body}) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},  // Cabeçalho para indicar JSON
      body: body,
    );
    return response;
  }

  @override
  Future<http.Response> put({required String url, required String body}) async {
    final response = await client.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},  // Cabeçalho para indicar JSON
      body: body,
    );
    return response;
  }

  @override
  Future<http.Response> delete({required String url}) async {
    final response = await client.delete(Uri.parse(url));
    return response;
  }
}
