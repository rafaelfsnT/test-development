class SearchResultModel {
  final String titulo;
  final String link;

  SearchResultModel({required this.titulo, required this.link});
  
// Método factory para criar uma instância de SearchResult a partir de um JSON
  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      titulo: json['titulo'] as String,
      link: json['link'] as String,
    );
  }
}