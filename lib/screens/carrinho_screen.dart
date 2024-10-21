import 'package:flutter/material.dart';
import '../models/produto.dart';

class CarrinhoScreen extends StatelessWidget {
  final List<Produto> carrinho;

  const CarrinhoScreen({super.key, required this.carrinho});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: ListView.builder(
        itemCount: carrinho.length,
        itemBuilder: (context, index) {
          var produto = carrinho[index];
          return ListTile(
            title: Text(produto.nome),
            subtitle: Text('R\$ ${produto.preco}'),
          );
        },
      ),
    );
  }
}
