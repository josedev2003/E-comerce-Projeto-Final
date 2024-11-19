class Produto {
  int? id = 1;
  String nome;
  String descricao;
  double preco;
  int categoriaId;
  String? imagePath; // Novo atributo para armazenar o caminho da imagem local

  Produto({
    this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.categoriaId,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'categoria_id': categoriaId,
      'image_path': imagePath, // Incluindo o caminho da imagem no mapa
    };
  }

  static Produto fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      preco: map['preco'],
      categoriaId: map['categoria_id'],
      imagePath: map['image_path'], // Recuperando o caminho da imagem do mapa
    );
  }
}
