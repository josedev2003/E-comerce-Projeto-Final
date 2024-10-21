// lib/models/produto.dart
import 'package:e_commerce/models/categorias.dart';

class Produto {
  int id;
  String nome;
  String descricao;
  double preco;
  Categoria categoria;  // Relacionamento com a Categoria

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.categoria,
  });

  void atualizarProduto(Produto dados) {
    // Atualiza os atributos do produto com base nos dados recebidos
    nome = dados.nome;
    descricao = dados.descricao;
    preco = dados.preco;
    categoria = dados.categoria;
  }
}
