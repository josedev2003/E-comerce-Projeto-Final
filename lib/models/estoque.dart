import 'package:e_commerce/models/produto.dart';

class Estoque {
  int? id;
  Produto produto;
  int quantidadeDisponivel;

  Estoque({
    this.id,
    required this.produto,
    required this.quantidadeDisponivel,
  });

  // Convertendo para Map para inserção no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'produto_id': produto.id, // Referência ao id do produto
      'quantidadeDisponivel': quantidadeDisponivel,
    };
  }

  // Método estático para criar uma instância de Estoque a partir do Map
  static Estoque fromMap(Map<String, dynamic> map, Produto produto) {
    return Estoque(
      id: map['id'],
      produto: produto,
      quantidadeDisponivel: map['quantidadeDisponivel'],
    );
  }
}
