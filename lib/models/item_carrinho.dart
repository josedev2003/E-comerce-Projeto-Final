import 'package:e_commerce/models/produto.dart'; // Certifique-se de importar a classe Produto.

class ItemCarrinho {
  Produto produto; // Produto que está no carrinho.
  int quantidade; // Quantidade desse produto.
  double precoTotal; // Preço total desse item no carrinho.

  // Construtor do ItemCarrinho.
  ItemCarrinho({
    required this.produto,
    required this.quantidade,
    required this.precoTotal,
  });

  // Converte o ItemCarrinho para um Map (para salvar no banco de dados).
  Map<String, dynamic> toMap() {
    return {
      'produto': produto.toMap(), // Certifique-se de que Produto também tenha um método toMap().
      'quantidade': quantidade,
      'precoTotal': precoTotal,
    };
  }

  // Cria um objeto ItemCarrinho a partir de um Map (para ler do banco de dados).
  factory ItemCarrinho.fromMap(Map<String, dynamic> map) {
    return ItemCarrinho(
      produto: Produto.fromMap(map['produto']), // Certifique-se de que Produto tenha um método fromMap().
      quantidade: map['quantidade'],
      precoTotal: map['precoTotal'],
    );
  }
}
