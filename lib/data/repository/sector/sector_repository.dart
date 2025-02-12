import 'dart:convert';
import 'package:myapp/data/http/http_client.dart';
import 'package:myapp/data/models/sector_model.dart';

class SectorRepository {
  final IHttpClient httpClient;

  SectorRepository(this.httpClient);

  // Buscar todos os setores
  Future<List<SectorModel>> getAllSectors(String url) async {
    final response = await httpClient.get(url: url);

    if (response.statusCode == 200) {
      final List<SectorModel> sectors = [];
      final body = jsonDecode(response.body);

      // Verifica se a chave 'sectors' existe na resposta
      if (body['sectors'] != null) {
        for (var item in body['sectors']) {
          sectors.add(SectorModel.fromMap(item));
        }
      }

      return sectors;
    } else {
      throw Exception('Falha ao carregar setores: ${response.statusCode}');
    }
  }

  // Buscar um setor 
  Future<SectorModel> getSectorById(String url) async {
    final response = await httpClient.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

     
      if (body != null) {
        return SectorModel.fromMap(body);
      } else {
        throw Exception('Setor não encontrado');
      }
    } else {
      throw Exception('Falha ao buscar setor: ${response.statusCode}');
    }
  }

  // Adicionar setor
  Future<void> addSector(String url, String body) async {
    final response = await httpClient.post(url: url, body: body);

    if (response.statusCode != 200) {
      throw Exception('Falha ao adicionar setor: ${response.statusCode}');
    }
  }

  // Editar setor
  Future<void> editSector(String url, String body) async {
    final response = await httpClient.put(url: url, body: body);

    if (response.statusCode != 200) {
      throw Exception('Falha ao editar setor: ${response.statusCode}');
    }
  }

  // Deletar setor
  Future<void> deleteSector(String url) async {
    final response = await httpClient.delete(url: url);

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar setor: ${response.statusCode}');
    }
  }
}
