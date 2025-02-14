import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future<http.Response> get({required String url});
  Future<http.Response> post({required String url, required String body});
  Future<http.Response> put({required String url, required String body});
  Future<http.Response> delete({required String url});
}

class HttpClient implements IHttpClient {
  final client = http.Client();
  
  // URL base da API
  final String baseUrl = 'https://solvo-checklist-api.azurewebsites.net/api';

  // Método GET
  @override
  Future<http.Response> get({required String url}) async {
    final fullUrl = Uri.parse('$baseUrl$url'); 
    
     // Concatena a URL base com o endpoint
    final response = await client.get(fullUrl);
    return response;
  }

  // Método POST
  @override
  Future<http.Response> post({required String url, required String body}) async {
    final fullUrl = Uri.parse('$baseUrl$url');  // Concatena a URL base com o endpoint
    final response = await client.post(
      fullUrl,
      headers: {'Content-Type': 'application/json'},  // Cabeçalho para indicar JSON
      body: body,
    );
    return response;
  }

  // Método PUT
  @override
  Future<http.Response> put({required String url, required String body}) async {
    final fullUrl = Uri.parse('$baseUrl$url');  // Concatena a URL base com o endpoint
    final response = await client.put(
      fullUrl,
      headers: {'Content-Type': 'application/json'},  // Cabeçalho para indicar JSON
      body: body,
    );
    return response;
  }

  // Método DELETE
  @override
  Future<http.Response> delete({required String url}) async {
    final fullUrl = Uri.parse('$baseUrl$url');  // Concatena a URL base com o endpoint
    final response = await client.delete(fullUrl);
    return response;
  }
}
