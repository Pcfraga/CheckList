import 'dart:convert';
import 'package:checklist/data/http/http_client.dart';
import 'package:checklist/data/models/getAllCheckList_model.dart';

class GetAllCheckListRepository {
  final IHttpClient httpClient;

  GetAllCheckListRepository(this.httpClient);

  // Buscar todos os CheckLists
  Future<List<GetAllCheckListModelsDTO>> getAllCheckList() async {
    final response = await httpClient.get(url: "/ChecklistModels");

    if (response.statusCode == 200) {
      final List<GetAllCheckListModelsDTO> checkLists = [];
      final body = jsonDecode(response.body);
      print("Helow $body");
      if (body is List) {
        for (var item in body) {
          print(item);
          checkLists.add(GetAllCheckListModelsDTO.fromMap(item));
        }
      }

      return checkLists;
    } else {
      throw Exception(
        'Falha ao carregar getAllCheckList: ${response.statusCode}',
      );
    }
  }

  // Buscar um CheckList específico
  Future<GetAllCheckListModelsDTO> getCheckListById(String url) async {
    final response = await httpClient.get(url: url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body != null) {
        return GetAllCheckListModelsDTO.fromMap(body);
      } else {
        throw Exception('getAllCheckList não encontrado');
      }
    } else {
      throw Exception(
        'Falha ao buscar getAllCheckList: ${response.statusCode}',
      );
    }
  }

  // Adicionar CheckList
  Future<void> addCheckList(String url, Map<String, dynamic> bodyMap) async {
    final body = jsonEncode(bodyMap); // Codifica o corpo como JSON
    final response = await httpClient.post(url: url, body: body);

    if (response.statusCode != 200) {
      throw Exception(
        'Falha ao adicionar getAllCheckList: ${response.statusCode}',
      );
    }
  }

  // Editar CheckList
  Future<void> editCheckList(String url, Map<String, dynamic> bodyMap) async {
    final body = jsonEncode(bodyMap); // Codifica o corpo como JSON
    final response = await httpClient.put(url: url, body: body);

    if (response.statusCode != 200) {
      throw Exception(
        'Falha ao editar getAllCheckList: ${response.statusCode}',
      );
    }
  }

  // Deletar CheckList
  Future<void> deleteCheckList(String url) async {
    final response = await httpClient.delete(url: url);

    if (response.statusCode != 200) {
      throw Exception(
        'Falha ao deletar getAllCheckList: ${response.statusCode}',
      );
    }
  }
}
