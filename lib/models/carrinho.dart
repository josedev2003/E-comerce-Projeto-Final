import 'package:e_commerce/models/cliente.dart'; // Importa a classe Cliente.
import 'package:e_commerce/models/item_carrinho.dart'; // Importa a classe ItemCarrinho.
import 'package:e_commerce/models/produto.dart'; // Importa a classe Produto.

class CarrinhoDeCompras {
  int id; // Identificador único para o carrinho.
  Cliente
      cliente; // Objeto que contém as informações do cliente associado ao carrinho.
  List<ItemCarrinho>
      itens; // Lista de itens (produtos e suas quantidades) no carrinho.
  double total; // Total do valor dos produtos no carrinho.

  // Construtor que inicializa o carrinho com um ID, cliente e lista de itens.
  CarrinhoDeCompras(
      {required this.id,
      required this.cliente,
      required this.itens,
      this.total = 0.0});

  // Método para adicionar um item ao carrinho.
  void adicionarItem(Produto produto, int quantidade) {
    ItemCarrinho item = ItemCarrinho(
        produto: produto,
        quantidade: quantidade,
        precoTotal: produto.preco * quantidade);
    itens.add(item);
    calcularTotal();
  }

  // Método para remover um item do carrinho.
  void removerItem(ItemCarrinho item) {
    itens.remove(item);
    calcularTotal();
  }

  // Método para calcular o total do carrinho.
  void calcularTotal() {
    total = itens.fold(0.0, (soma, item) => soma + item.precoTotal);
  }

  // Converte o CarrinhoDeCompras em um Map (para salvar no banco de dados).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': cliente.toMap(), // Convertendo o cliente para um Map.
      'itens': itens
          .map((item) => item.toMap())
          .toList(), // Convertendo a lista de itens para Map.
      'total': total,
    };
  }

  // Cria um objeto CarrinhoDeCompras a partir de um Map (para ler do banco de dados).
  factory CarrinhoDeCompras.fromMap(Map<String, dynamic> map) {
    return CarrinhoDeCompras(
      id: map['id'],
      cliente:
          Cliente.fromMap(map['cliente']), // Reconstruindo o objeto Cliente.
      itens: List<ItemCarrinho>.from(map['itens'].map((itemMap) =>
          ItemCarrinho.fromMap(
              itemMap))), // Convertendo cada item do Map para ItemCarrinho.
      total: map['total'],
    );
  }
}
