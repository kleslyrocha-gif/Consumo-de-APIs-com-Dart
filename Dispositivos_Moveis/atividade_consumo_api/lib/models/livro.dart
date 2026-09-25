class Livro {
  final String titulo;
  final String autor;
  final int ano;
  final String capa;
  final int quantidadePaginas;

  Livro({
    required this.titulo,
    required this.autor,
    required this.ano,
    required this.capa,
    required this.quantidadePaginas,
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    final autores = json['author_name'] as List?;

    return Livro(
      titulo: json['title'] ?? 'Título não informado',
      autor: autores != null && autores.isNotEmpty
          ? autores[0].toString()
          : 'Autor não informado',
      ano: json['first_publish_year'] ?? 0,
      capa: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg'
          : 'Capa não disponível',
      quantidadePaginas: json['number_of_pages_median'] ?? 0,
    );
  }
}