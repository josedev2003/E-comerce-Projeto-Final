import "produto.dart";

class ItemCarrinho {
  Produto produto;
  int quantidade;
  double precoTotal;

  ItemCarrinho({
    required this.produto,
    required this.quantidade,
    required this.precoTotal,
  });
}
