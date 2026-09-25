import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/livro.dart';

class LivroService {
  static const String urlBase =
      'https://openlibrary.org/search.json';

  Future<List<Livro>> buscarLivros(String pesquisa) async {
    final consulta = Uri.encodeQueryComponent(pesquisa);

    final url = Uri.parse('$urlBase?q=$consulta');

    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final Map<String, dynamic> dados =
          jsonDecode(resposta.body);

      final List resultados = dados['docs'];

      if (resultados.isEmpty) {
        throw Exception('Nenhum livro encontrado.');
      }

      return resultados
          .take(5)
          .map((livro) => Livro.fromJson(livro))
          .toList();
    }

    if (resposta.statusCode == 404) {
      throw Exception('Nenhum resultado encontrado.');
    }

    if (resposta.statusCode >= 500) {
      throw Exception('Erro interno da API.');
    }

    throw Exception(
      'Erro ao acessar a API. Código: ${resposta.statusCode}',
    );
  }
}