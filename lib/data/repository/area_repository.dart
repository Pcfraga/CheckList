import 'dart:convert';
import 'package:checklist/data/http/http_client.dart';
import 'package:checklist/data/models/area_model.dart';

class AreaRepository {
  final IHttpClient httpClient;

  // URL base para o endpoint "areas"
  final String baseUrl =
      'https://solvo-checklist-api.azurewebsites.net/api/areas';

  AreaRepository(this.httpClient);

  // Método para buscar todas as áreas
  Future<List<AreaModel>> getAllAreas() async {
    final response = await httpClient.get(
      url: baseUrl,
    ); // A URL completa é usada aqui

    if (response.statusCode == 200) {
      final List<AreaModel> areas = [];
      final body = jsonDecode(response.body);

      if (body['areas'] != null) {
        for (var item in body['areas']) {
          areas.add(AreaModel.fromMap(item));
        }
      }

      return areas;
    } else {
      throw Exception('Falha ao carregar áreas: ${response.statusCode}');
    }
  }

  // Método para buscar área por ID
  Future<AreaModel> getAreaById(String areaId) async {
    final url = '$baseUrl/$areaId'; // Concatena o ID da área com a URL base
    final response = await httpClient.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body != null) {
        return AreaModel.fromMap(body);
      } else {
        throw Exception('Área não encontrada');
      }
    } else {
      throw Exception('Falha ao buscar área: ${response.statusCode}');
    }
  }

  // Método para adicionar uma nova área
  Future<void> addArea(String body) async {
    final response = await httpClient.post(
      url: baseUrl,
      body: body,
    ); // Usa a URL base para o POST

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar área: ${response.statusCode}');
    }
  }

  // Método para editar uma área existente
  Future<void> editArea(String areaId, String body) async {
    final url = '$baseUrl/$areaId'; // Concatena o ID da área com a URL base
    final response = await httpClient.put(
      url: url,
      body: body,
    ); // Usa a URL completa para o PUT

    if (response.statusCode != 200) {
      throw Exception('Falha ao editar área: ${response.statusCode}');
    }
  }

  // Método para deletar uma área
  Future<void> deleteArea(String areaId) async {
    final url = '$baseUrl/$areaId'; // Concatena o ID da área com a URL base
    final response = await httpClient.delete(
      url: url,
    ); // Usa a URL completa para o DELETE

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar área: ${response.statusCode}');
    }
  }
}
