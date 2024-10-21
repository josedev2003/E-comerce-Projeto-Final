// lib/models/pedido.dart
import 'item_carrinho.dart';

class Pedido {
  int id;
  List<ItemCarrinho> itens;
  String status;

  Pedido({
    required this.id,
    required this.itens,
    this.status = 'Pendente',
  });

  void atualizarStatus(String novoStatus) {
    status = novoStatus;
  }
}
