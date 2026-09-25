import 'package:atividade_consumo_api/services/livro_service.dart';
import 'dart:io';

Future<void> main() async {
  final service = LivroService();

  bool continuar = true;

  final List<String> historico = [];

  print('========================================');
  print('       CONSULTA DE LIVROS');
  print('       OPEN LIBRARY');
  print('========================================');

  while (continuar) {
    print('\nMENU');
    print('1 - Consultar livros');
    print('2 - Exibir histórico');
    print('3 - Limpar histórico');
    print('0 - Encerrar');

    stdout.write('\nEscolha uma opção: ');
    final opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        stdout.write('\nDigite o nome do livro ou autor: ');

        final pesquisa = stdin.readLineSync();

        if (pesquisa == null || pesquisa.trim().isEmpty) {
          print('\nDigite uma informação válida.');
          break;
        }

        try {
          print('\nConsultando a Open Library...');

          final livros = await service.buscarLivros(pesquisa);

          historico.add(pesquisa);

          print('\n========================================');
          print('RESULTADOS');
          print('========================================');

          for (int i = 0; i < livros.length; i++) {
            final livro = livros[i];

            print('\nLivro ${i + 1}');
            print('Título: ${livro.titulo}');
            print('Autor: ${livro.autor}');
            print('Ano de publicação: ${livro.ano}');
            print('Quantidade de páginas: ${livro.quantidadePaginas}');
            print('Capa: ${livro.capa}');
          }
        } catch (erro) {
          print('\nNão foi possível realizar a consulta.');
          print('Motivo: $erro');
        }

        break;

      case '2':
        print('\n========================================');
        print('HISTÓRICO DE CONSULTAS');
        print('========================================');

        if (historico.isEmpty) {
          print('Nenhuma consulta realizada.');
        } else {
          for (int i = 0; i < historico.length; i++) {
            print('${i + 1}. ${historico[i]}');
          }
        }

        break;

      case '3':
        historico.clear();
        print('\nHistórico apagado com sucesso.');

        break;

      case '0':
        continuar = false;
        print('\nPrograma encerrado.');

        break;

      default:
        print('\nOpção inválida.');
    }
  }
}
