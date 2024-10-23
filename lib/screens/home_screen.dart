// Importa a classe Categoria para gerenciar categorias de produtos.
import 'package:e_commerce/database/categoria_dao.dart';
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../models/categoria.dart'; // Importa a classe Categoria. // Importa o DAO de Categoria.
import 'produto_screen.dart';
import 'carrinho_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required List<String> categorias});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Produto> produtos = [
    Produto(
      id: null,
      nome: "Tênis Esportivo",
      descricao: "Super tênis de corrida",
      preco: 150.00,
      categoriaId: 1, // Verifique se o ID aqui corresponde à categoria.
    ),
    Produto(
      id: null,
      nome: "Tênis Casual",
      descricao: "Tênis confortável para o dia a dia",
      preco: 120.00,
      categoriaId: 2,
    ),
    Produto(
      id: null,
      nome: "Bota de Aventura",
      descricao: "Bota resistente para trilhas",
      preco: 300.00,
      categoriaId: 3,
    ),
  ];

  List<Categoria> categorias =[]; // Lista para armazenar categorias do banco de dados.
  int categoriaSelecionadaId = 0; // ID da categoria selecionada, inicializa como "Todos".
  String categoriaSelecionada = 'Todos';
  List<Produto> carrinho = [];

Future<void> _carregarCategorias() async {
  try {
    categorias = await CategoriaDAO().getCategorias();

    // Verifique se as categorias foram carregadas
    if (categorias.isNotEmpty) {
      print('Categorias carregadas: ${categorias.map((c) => c.nome).toList()}');
    } else {
      print('Nenhuma categoria encontrada.');
    }

    // Atualiza o estado para refletir as categorias carregadas.
    setState(() {});
  } catch (e) {
    // Exibe um erro no console se houver problemas ao carregar categorias.
    print('Erro ao carregar categorias: $e');
  }
}

Future<void> _inserirDados() async {
  await CategoriaDAO().insertCategoria(Categoria(nome: 'Categoria 1'));
  await CategoriaDAO().insertCategoria(Categoria(nome: 'Categoria 2'));
}

  @override
  void initState() {
  super.initState();
  _inserirDados(); // Método para inserir dados para teste
  _carregarCategorias(); // Carrega as categorias ao iniciar o widget.
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
        : produtos
            .where((produto) => produto.categoriaId == categoriaSelecionadaId)
            .toList();

    return Scaffold(
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
                ? CircularProgressIndicator() // Mostra um carregando se as categorias não estiverem carregadas.
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categorias.map((categoria) {
                      return ChoiceChip(
                        label: Text(categoria.nome),
                        selected: categoria.nome == categoriaSelecionada,
                        onSelected: (selected) {
                          setState(() {
                            categoriaSelecionada = categoria.nome;
                            categoriaSelecionadaId = categoria
                                .id!; // Atualiza o ID da categoria selecionada.
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
