

import 'item_carrinho.dart';

class Pedido {
  int id;
  List<ItemCarrinho> itens;
  String status;

  Pedido({
    required this.id,
    required this.itens,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itens': itens,
      'status': status,
    };
  }

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      id: map['id'],
      itens: map['itens'],
      status: map['status'],
    );
  }

  void processarPagamento() {
    status = 'pago'; 
  }
}
