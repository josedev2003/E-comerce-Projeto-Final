

import 'package:e_commerce/models/pedidos.dart';

class Cliente {
  int id;
  String nome;
  String cpf;
  String endereco;
  String email; 
  List<Pedido> pedidos;
 
   Cliente({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.endereco,
    required this.email,
    required this.pedidos,
  });

  void atualizarCadastro(Cliente novoCliente) {
    nome = novoCliente.nome;
    cpf = novoCliente.cpf;
    endereco = novoCliente.endereco;
    email = novoCliente.email;
  }

  void realizarPedido(Pedido pedido) {
    pedidos.add(pedido);
  }
}

