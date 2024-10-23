class Produto {
  int? id;
  String nome;
  String descricao;
  double preco;
  int categoriaId;

  Produto({this.id, required this.nome, required this.descricao, required this.preco, required this.categoriaId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'categoria_id': categoriaId,
    };
  }

  static Produto fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      preco: map['preco'],
      categoriaId: map['categoria_id'],
    );
  }
}
