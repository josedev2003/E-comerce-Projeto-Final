// Importa a classe Categoria para gerenciar categorias de produtos.
import 'package:e_commerce/database/categoria_dao.dart';
import 'package:e_commerce/database/produto_dao.dart';
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../models/categoria.dart'; // Importa a classe Categoria. // Importa o DAO de Categoria.
import 'produto_screen.dart';
import 'carrinho_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required List<String> categorias});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Produto> produtos = []; // Lista para armazenar produtos do banco de dados
  List<Categoria> categorias = []; // Lista para armazenar categorias do banco de dados.
  int categoriaSelecionadaId = 0; // ID da categoria selecionada, inicializa como "Todos".
  String categoriaSelecionada = 'Todos';
  List<Produto> carrinho = [];

  Future<void> _carregarProdutos() async {
    try {
      produtos = await ProdutoDAO().getProdutos(); // Carrega produtos do banco de dados

      // Verifique se os produtos foram carregados
      if (produtos.isNotEmpty) {
        // ignore: avoid_print
        print('Produtos carregados: ${produtos.map((p) => p.nome).toList()}');
      } else {
        // ignore: avoid_print
        print('Nenhum produto encontrado.');
      }

      // Atualiza o estado para refletir os produtos carregados.
      setState(() {});
    } catch (e) {
      // Exibe um erro no console se houver problemas ao carregar produtos.
      // ignore: avoid_print
      print('Erro ao carregar produtos: $e');
    }
  }

  Future<void> _carregarCategorias() async {
    try {
      categorias = await CategoriaDAO().getCategorias();

      // Verifique se as categorias foram carregadas
      if (categorias.isNotEmpty) {
        // ignore: avoid_print
        print('Categorias carregadas: ${categorias.map((c) => c.nome).toList()}');
      } else {
        // ignore: avoid_print
        print('Nenhuma categoria encontrada.');
      }

      // Atualiza o estado para refletir as categorias carregadas.
      setState(() {});
    } catch (e) {
      // Exibe um erro no console se houver problemas ao carregar categorias.
      // ignore: avoid_print
      print('Erro ao carregar categorias: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarCategorias(); // Carrega as categorias ao iniciar o widget.
    _carregarProdutos(); // Carrega os produtos ao iniciar o widget.
  }

  void adicionarCarrinho(Produto produto) {
    setState(() {
      carrinho.add(produto);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Produto> produtosFiltrados = categoriaSelecionadaId == 0
        ? produtos
        : produtos.where((produto) => produto.categoriaId == categoriaSelecionadaId).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Produtos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarrinhoScreen(carrinho: carrinho),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros de categoria, assegure-se de que as categorias estão carregadas.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: categorias.isEmpty
                ? const CircularProgressIndicator() // Mostra um carregando se as categorias não estiverem carregadas.
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categorias.map((categoria) {
                      return ChoiceChip(
                        label: Text(categoria.nome),
                        selected: categoria.id == categoriaSelecionadaId,
                        onSelected: (selected) {
                          setState(() {
                            categoriaSelecionada = categoria.nome;
                            categoriaSelecionadaId = categoria.id!; // Atualiza o ID da categoria selecionada.
                          });
                        },
                      );
                    }).toList(),
                  ),
          ),
          // Exibição dos produtos filtrados.
          Expanded(
            child: ListView.builder(
              itemCount: produtosFiltrados.length,
              itemBuilder: (context, index) {
                var produto = produtosFiltrados[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text(produto.descricao),
                  trailing: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoScreen(
                          produto: produto,
                          adicionarCarrinho: adicionarCarrinho,
                          carrinho: carrinho,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
