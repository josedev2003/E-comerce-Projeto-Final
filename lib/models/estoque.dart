import 'package:e_commerce/models/produto.dart';

class Estoque {
  Produto produto;
  int quantidadeDisponivel;

  Estoque({required this.produto, required this.quantidadeDisponivel});

  void atualizarEstoque(int quantidade) {
    quantidadeDisponivel = quantidade;
  }
}
