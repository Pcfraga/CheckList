import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/data/models/loginView_model.dart';

class LoginViewRepository {
  final String apiUrl =
      'https://solvo-checklist-api.azurewebsites.net/api/login';

  Future<bool> login(LoginViewModel loginViewModel) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'content-type': 'application /json'},
        body: json.encode({
          'email': loginViewModel.email,
          'password': loginViewModel.password,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Erro ao tentar fazer login: $e");
       return false;
    }
  }
}
