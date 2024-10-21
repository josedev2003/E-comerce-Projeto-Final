import 'package:e_commerce/models/cliente.dart'; // Importa a classe Cliente, que contém informações sobre o cliente.
import 'package:e_commerce/models/item_carrinho.dart'; // Importa a classe ItemCarrinho, que representa um item no carrinho de compras.
import 'package:e_commerce/models/produto.dart'; // Importa a classe Produto, que representa o produto sendo adicionado ao carrinho.

class CarrinhoDeCompras {
  int id; // Identificador único para o carrinho.
  Cliente cliente; // Objeto que contém as informações do cliente associado ao carrinho.
  List<ItemCarrinho> itens; // Lista de itens (produtos e suas quantidades) no carrinho.
  double total; // Total do valor dos produtos no carrinho.

  // Construtor que inicializa o carrinho com um ID, cliente e lista de itens.
  // O total começa em 0.0 por padrão.
  CarrinhoDeCompras(
      {required this.id,
      required this.cliente,
      required this.itens,
      this.total = 0.0});

  // Método para adicionar um item ao carrinho.
  // Recebe um produto e a quantidade desejada como parâmetros.
  void adicionarItem(Produto produto, int quantidade) {
    // Cria um novo item para o carrinho, contendo o produto, quantidade e o preço total (preço do produto * quantidade).
    ItemCarrinho item = ItemCarrinho(
        produto: produto,
        quantidade: quantidade,
        precoTotal: produto.preco * quantidade);
    // Adiciona o item à lista de itens do carrinho.
    itens.add(item);
    // Recalcula o total do carrinho após adicionar o item.
    calcularTotal();
  }

  // Método para remover um item do carrinho.
  // Recebe o item que deve ser removido como parâmetro.
  void removerItem(ItemCarrinho item) {
    // Remove o item da lista de itens.
    itens.remove(item);
    // Recalcula o total do carrinho após remover o item.
    calcularTotal();
  }

  // Método para calcular o total do carrinho.
  // Ele soma o preço total de todos os itens na lista de itens.
  void calcularTotal() {
    // Usa o método fold para somar o preço total de cada item, começando do valor 0.0.
    total = itens.fold(0.0, (soma, item) => soma + item.precoTotal);
  }
}
