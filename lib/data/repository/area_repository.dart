import 'dart:convert';
import 'package:myapp/data/http/http_client.dart';
import 'package:myapp/data/models/area_model.dart';

class AreaRepository {
  final IHttpClient httpClient;

  AreaRepository(this.httpClient);

  Future<List<AreaModel>> getAllAreas(String url) async {
    final response = await httpClient.get(url: url);

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

  Future<AreaModel> getAreaById(String url) async {
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

  Future<void> addArea(String url, String body) async {
    final response = await httpClient.post(url: url, body: body);

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar área: ${response.statusCode}');
    }
  }

  Future<void> editArea(String url, String body) async {
    final response = await httpClient.put(url: url, body: body);

    if (response.statusCode != 200) {
      throw Exception('Falha ao editar área: ${response.statusCode}');
    }
  }

  Future<void> deleteArea(String url) async {
    final response = await httpClient.delete(url: url);

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar área: ${response.statusCode}');
    }
  }
}
