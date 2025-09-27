import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_development/model/search_result_model.dart';

class SearchApiService {
  final String baseUrl = 'http://10.0.2.2:3000/api/search';
  // final String baseUrl = 'http://localhost:3000/api/search';
  // Use esta linha se estiver testando em um navegador ou ambiente que não seja o emulador Android

  Future<List<SearchResultModel>> search(String query) async {
    final uri = Uri.parse('$baseUrl?q=${Uri.encodeComponent(query)}');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => SearchResultModel.fromJson(json)).toList();
      } else {
        // Trata erros de requisição (ex: 404, 500)
        throw Exception(
          'Falha ao carregar resultados. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Trata erros de conexão (ex: servidor Node.js offline)
      print('Erro de comunicação com a API: $e');
      throw Exception(
        'Erro de rede ou servidor. Verifique se o Node.js está rodando.',
      );
    }
  }
}
