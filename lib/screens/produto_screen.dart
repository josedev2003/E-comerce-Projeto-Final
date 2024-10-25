import 'package:e_commerce/database/produto_dao.dart';
import 'package:flutter/material.dart';
import '../models/produto.dart';


class ProdutoScreen extends StatefulWidget {
  final Produto produto;
  final List<Produto> carrinho;
  final void Function(Produto produto) adicionarCarrinho;

  const ProdutoScreen({
    super.key,
    required this.produto,
    required this.carrinho,
    required this.adicionarCarrinho,
  });

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
              'Categoria: ${widget.produto.categoriaId}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text('Preço: R\$ ${widget.produto.preco}'),
            const SizedBox(height: 16),
            Text(widget.produto.descricao),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Use o DatabaseHelper para inserir o produto
                  await ProdutoDAO().insertProduto(widget.produto); // Use a instância do singleton
                  // Adicione o produto ao carrinho
                  widget.adicionarCarrinho(widget.produto);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.produto.nome} adicionado ao banco de dados e ao carrinho!')),
                  );
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao adicionar ${widget.produto.nome}: $e')),
                  );
                }
              },
              child: const Text('Adicionar ao Banco de Dados e Carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}
