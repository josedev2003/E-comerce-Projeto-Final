import 'package:e_commerce/components/buttom_navigation_bar.dart';
import 'package:e_commerce/database/categoria_dao.dart';
import 'package:e_commerce/database/cliente_dao.dart';
import 'package:e_commerce/database/produto_dao.dart';
import 'package:e_commerce/models/cliente.dart';
import 'package:e_commerce/screens/cliente_screen.dart';
import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../models/categoria.dart';
import 'produto_screen.dart';
import 'carrinho_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required List<String> categorias});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Produto> produtos = [];
  List<Categoria> categorias = [];
  int categoriaSelecionadaId = 0;
  String categoriaSelecionada = 'Todos';
  List<Produto> carrinho = [];
  int _selectedIndex = 0;

  Future<void> _carregarProdutos() async {
    try {
      produtos = await ProdutoDAO().getProdutos();
      setState(() {}); 
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  Future<void> _carregarCategorias() async {
    try {
      categorias = await CategoriaDAO().getCategorias();
      setState(() {}); 
    } catch (e) {
      print('Erro ao carregar categorias: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
    _carregarProdutos();
  }

  void adicionarCarrinho(Produto produto) {
    setState(() {
      carrinho.add(produto);
    });
  }

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
           builder: (context) => CarrinhoScreen(carrinho: carrinho)
          ),
        );
        break;
      case 2:
      String emailDoCliente = ""; // Email correto
      Cliente? cliente = await ClienteDAO().getClienteByEmail(emailDoCliente);

      if (cliente != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserScreen(cliente: cliente),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cliente não encontrado.'),
          ),
        );
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Produto> produtosFiltrados = categoriaSelecionadaId == 0
        ? produtos
        : produtos.where((produto) => produto.categoriaId == categoriaSelecionadaId).toList();

    return Scaffold(
      backgroundColor: Color(0xfff6fcdf),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Produtos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff1a1a19),
            fontStyle: FontStyle.italic,
            backgroundColor: Color(0xfff6fcdf)
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
      backgroundColor: Color(0xfff6fcdf),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: categorias.isEmpty
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categorias.map((categoria) {
                      return ChoiceChip(
                        label: Text(categoria.nome),
                        selected: categoria.id == categoriaSelecionadaId,
                        onSelected: (selected) {
                          setState(() {
                            categoriaSelecionada = categoria.nome;
                            categoriaSelecionadaId = categoria.id!;
                          });
                        },
                      );
                    }).toList(),
                  ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 produtos por linha
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75, // Ajuste a proporção conforme necessário
              ),
              itemCount: produtosFiltrados.length,
              itemBuilder: (context, index) {
                var produto = produtosFiltrados[index];
                return GestureDetector(
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
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.asset(
                              produto.imagePath ?? 'assets/images/placeholder.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            produto.nome,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1a1a19),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            produto.descricao,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff1a1a19),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'R\$ ${produto.preco.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
