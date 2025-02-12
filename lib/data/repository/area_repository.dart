import 'dart:convert';
import 'package:myapp/data/http/http_client.dart';
import 'package:myapp/data/models/area_model.dart';

class AreaRepository {
  final IHttpClient httpClient;

  // Corrigindo: Removendo o parâmetro 'client' redundante no construtor
  AreaRepository(this.httpClient);

  // Buscar todas as áreas
  Future<List<AreaModel>> getAllAreas(String url) async {
    final response = await httpClient.get(url: url);

    if (response.statusCode == 200) {
      final List<AreaModel> areas = [];
      final body = jsonDecode(response.body);

      // Verifica se a chave 'areas' existe na resposta
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

  // Buscar uma área específica 
  Future<AreaModel> getAreaById(String url) async {
    final response = await httpClient.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      // Verifica se a área foi encontrada
      if (body != null) {
        return AreaModel.fromMap(body);
      } else {
        throw Exception('Área não encontrada');
      }
    } else {
      throw Exception('Falha ao buscar área: ${response.statusCode}');
    }
  }

  // Adicionar área
  Future<void> addArea(String url, String body) async {
    final response = await httpClient.post(url: url, body: body);

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar área: ${response.statusCode}');
    }
  }

  // Editar área
  Future<void> editArea(String url, String body) async {
    final response = await httpClient.put(url: url, body: body);

    if (response.statusCode != 200) {
      throw Exception('Falha ao editar área: ${response.statusCode}');
    }
  }

  // Deletar área
  Future<void> deleteArea(String url) async {
    final response = await httpClient.delete(url: url);

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar área: ${response.statusCode}');
    }
  }
}
