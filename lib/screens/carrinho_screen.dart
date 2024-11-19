import 'package:e_commerce/database/estoque_dao.dart';
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../models/estoque.dart';

class CarrinhoScreen extends StatefulWidget {
  final List<Produto> carrinho;

  const CarrinhoScreen({super.key, required this.carrinho});

  @override
  _CarrinhoScreenState createState() => _CarrinhoScreenState();
}

class _CarrinhoScreenState extends State<CarrinhoScreen> {
  final EstoqueDAO estoqueDAO = EstoqueDAO();

  Future<int> getEstoqueDisponivel(int produtoId) async {
    Estoque? estoque = await estoqueDAO.getEstoque(produtoId);
    print('Estoque recuperado para o produto $produtoId: ${estoque?.quantidadeDisponivel}');
    return estoque?.quantidadeDisponivel ?? 0;
  }

  Future<void> finalizarCompra() async {
    List<Produto> produtosParaRemover = [];

    // Verifica se o estoque é suficiente para cada produto do carrinho
    for (var produto in widget.carrinho) {
      int quantidadeCompra = 1; // Ou defina a quantidade com base no carrinho

      Estoque? estoque = await estoqueDAO.getEstoque(produto.id!);
      int estoqueDisponivel = estoque?.quantidadeDisponivel ?? 0;

      print('Produto: ${produto.nome}, Estoque disponível: $estoqueDisponivel');

      if (estoqueDisponivel >= quantidadeCompra) {
        // Atualiza o estoque, diminuindo a quantidade comprada
        await estoqueDAO.updateEstoque(produto.id!, estoqueDisponivel - quantidadeCompra);
        print('Compra realizada: ${produto.nome}, estoque atualizado para: ${estoqueDisponivel - quantidadeCompra}.');

        // Adiciona o produto à lista para ser removido do carrinho
        produtosParaRemover.add(produto);
      } else {
        print('Estoque insuficiente para o produto: ${produto.nome}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Estoque insuficiente para ${produto.nome}')),
        );
      }
    }

    // Atualiza o carrinho, removendo os produtos comprados
    if (produtosParaRemover.isNotEmpty) {
      setState(() {
        widget.carrinho.removeWhere((produto) => produtosParaRemover.contains(produto));
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Compra realizada com sucesso!'),
      ));
    }
  }

  double calcularPrecoTotal() {
    double total = 0;
    for (var produto in widget.carrinho) {
      total += produto.preco; // Agora você não utiliza mais quantidade diretamente no produto
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6fcdf),
      appBar: AppBar(
        backgroundColor: const Color(0xfff6fcdf),
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.carrinho.length,
              itemBuilder: (context, index) {
                var produto = widget.carrinho[index];
                return ListTile(
                  leading: produto.imagePath != null && produto.imagePath!.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              produto.imagePath!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.grey,
                        ),
                  title: Text(produto.nome),
                  subtitle: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
                  trailing: Text('Qtd: 1'), // Ajuste de quantidade
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total: ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'R\$ ${calcularPrecoTotal().toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await finalizarCompra();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Compra realizada com sucesso!'),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    'Comprar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
