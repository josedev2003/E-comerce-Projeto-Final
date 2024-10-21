import 'package:flutter/material.dart';
import '../models/produto.dart';

class ProdutoScreen extends StatefulWidget {
  final Produto produto;
  final Function(Produto) adicionarCarrinho;

  const ProdutoScreen(
      {super.key, required this.produto, required this.adicionarCarrinho, required List<Produto> carrinho});

  @override
  // ignore: library_private_types_in_public_api
  _ProdutoScreenState createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produto.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.produto.nome,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Categoria: ${widget.produto.categoria}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Preço: R\$ ${widget.produto.preco}',
            ),
            const SizedBox(height: 16),
            Text(widget.produto.descricao),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                widget.adicionarCarrinho(widget.produto);
              },
              child: const Text('Adicionar ao Carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}
