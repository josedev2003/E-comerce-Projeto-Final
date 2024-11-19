import 'dart:io';
import 'package:e_commerce/models/estoque.dart';
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../database/estoque_dao.dart'; // Certifique-se de importar o EstoqueDAO

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
  _ProdutoScreenState createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  final EstoqueDAO estoqueDAO = EstoqueDAO();
  int quantidadeEstoque = 10;  // Inicializa com 0, será atualizado posteriormente

  @override
  void initState() {
    super.initState();
    _carregarEstoque();  // Chama o método para carregar a quantidade de estoque
  }

  // Método para carregar a quantidade de estoque
  void _carregarEstoque() async {
  Estoque? estoque = await estoqueDAO.getEstoque(widget.produto.id!);
    if (estoque != null) {
      setState(() {
        quantidadeEstoque = estoque.quantidadeDisponivel;  // Atualiza a quantidade de estoque
      });
    }
  }

  Future<void> adicionarAoCarrinho() async {
    try {
      // Adiciona o print para verificar o ID do produto
      print('ID do produto: ${widget.produto.id}');
      
      // Verifica se há estoque suficiente
      if (quantidadeEstoque > 0) {
        // Atualiza o estoque no banco de dados, reduzindo 1 unidade
        await estoqueDAO.updateEstoque(widget.produto.id!, quantidadeEstoque - 0);

        // Adiciona o produto ao carrinho
        widget.adicionarCarrinho(Produto(
          id: widget.produto.id,
          nome: widget.produto.nome,
          descricao: widget.produto.descricao,
          preco: widget.produto.preco,
          categoriaId: widget.produto.categoriaId,  // Certifique-se de que o campo 'categoriaId' existe em Produto
          imagePath: widget.produto.imagePath,
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.produto.nome} adicionado ao carrinho!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Estoque insuficiente para ${widget.produto.nome}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar ${widget.produto.nome}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Log do caminho da imagem
    debugPrint('Caminho da imagem: ${widget.produto.imagePath}');

    return Scaffold(
      backgroundColor: const Color(0xfff6fcdf),
      appBar: AppBar(
        backgroundColor: const Color(0xfff6fcdf),
        title: Text(
          widget.produto.nome,
          style: const TextStyle(
            fontFamily: "Prata",
            fontWeight: FontWeight.bold,
            color: Color(0xff1a1a19),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xff859f3d), width: 2),
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xff31511e),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: widget.produto.imagePath != null
                      ? (widget.produto.imagePath!.startsWith('assets/')
                          ? Image.asset(
                              widget.produto.imagePath!,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return const Center(child: Text('Imagem não disponível'));
                              },
                            )
                          : Image.file(
                              File(widget.produto.imagePath!),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ))
                      : const Placeholder(
                          fallbackHeight: 200,
                          fallbackWidth: double.infinity,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                widget.produto.nome,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                    fontFamily: "Prata",
                    color: const Color(0xff1a1a19),
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                widget.produto.descricao,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontFamily: "Prata",
                    color: const Color(0xff1a1a19),
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'Estoque Disponível: $quantidadeEstoque', // Exibindo a quantidade carregada do estoque
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontFamily: "Prata",
                    color: const Color(0xff1a1a19),
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'Preço: R\$ ${widget.produto.preco.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                    fontFamily: "Prata",
                    color: const Color(0xff1a1a19),
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff859f3d),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: adicionarAoCarrinho,
                child: const Text(
                  'Adicionar ao Carrinho',
                  style: TextStyle(
                    color: Color(0xff1a1a19),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
