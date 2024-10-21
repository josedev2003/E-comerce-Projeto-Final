import 'package:e_commerce/models/categorias.dart'; // Importa a classe Categoria, que contém informações sobre as categorias de produtos.
import 'package:flutter/material.dart'; // Importa o pacote Flutter para construção da interface gráfica.
import '../models/produto.dart'; // Importa a classe Produto, que contém informações sobre os produtos.
import 'produto_screen.dart'; // Importa a tela de detalhes de produto.
import 'carrinho_screen.dart'; // Importa a tela do carrinho de compras.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // Construtor da tela inicial.

  @override
  // Cria o estado da HomeScreen (onde os dados mudam dinamicamente).
  _HomeScreenState createState() => _HomeScreenState();
}

// Criação de categorias para os produtos.
final Categoria esportivo = Categoria(
  nome: "Esportivo", // Nome da categoria.
  id: 1, // ID da categoria.
);
final Categoria casual = Categoria(nome: "Casual", id: 2);
final Categoria aventura = Categoria(nome: "Aventura", id: 3);

class _HomeScreenState extends State<HomeScreen> {
  // Lista de produtos disponíveis para exibição e compra.
  final List<Produto> produtos = [
    Produto(
        id: 1,
        nome: "Tênis Esportivo",
        descricao: "Super tênis de corrida", // Descrição do produto.
        preco: 150.00, // Preço do produto.
        categoria: esportivo), // Categoria à qual o produto pertence.
    Produto(
        id: 2,
        nome: "Tênis Casual",
        descricao: "Tênis confortável para o dia a dia",
        preco: 120.00,
        categoria: casual),
    Produto(
        id: 3,
        nome: "Bota de Aventura",
        descricao: "Bota resistente para trilhas",
        preco: 300.00,
        categoria: aventura),
  ];

  // Lista de categorias para escolha (inclui uma opção "Todos" que mostra todos os produtos).
  final List<String> categorias = ["Todos", "Esportivo", "Casual", "Aventura"];

  // Categoria selecionada pelo usuário.
  String categoriaSelecionada = "Todos";

  // Lista de produtos adicionados ao carrinho.
  List<Produto> carrinho = [];

  // Função para adicionar um produto ao carrinho.
  void adicionarCarrinho(Produto produto) {
    setState(() {
      carrinho
          .add(produto); // Adiciona o produto selecionado à lista de carrinho.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtra os produtos com base na categoria selecionada. Se a categoria for "Todos", mostra todos os produtos.
    List<Produto> produtosFiltrados = categoriaSelecionada == "Todos"
        ? produtos
        // Caso contrário, mostra apenas os produtos da categoria selecionada.
        : produtos
            .where((produto) => produto.categoria.nome == categoriaSelecionada)
            .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Produtos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold, // Negrito
            color: Colors.blueGrey, // Cor do texto
            fontStyle: FontStyle.italic, // Texto em itálico (opcional)
          ),
        ),
        // Título da AppBar.
        actions: [
          IconButton(
            icon: const Icon(
                Icons.shopping_cart), // Ícone do carrinho de compras.
            onPressed: () {
              // Quando o botão do carrinho é pressionado, navega para a tela do carrinho de compras.
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CarrinhoScreen(
                          carrinho: carrinho,
                        )), // Passa a lista de itens do carrinho para a próxima tela.
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Lista de categorias (filtros para exibir os produtos).
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categorias.map((categoria) {
                return ChoiceChip(
                  label: Text(categoria), // Nome da categoria exibida.
                  selected: categoria ==
                      categoriaSelecionada, // Verifica se a categoria está selecionada.
                  onSelected: (selected) {
                    setState(() {
                      categoriaSelecionada =
                          categoria; // Atualiza a categoria selecionada ao clicar.
                    });
                  },
                );
              }).toList(),
            ),
          ),
          // Lista de produtos filtrados por categoria.
          Expanded(
            child: ListView.builder(
              itemCount: produtosFiltrados
                  .length, // Número de produtos na lista filtrada.
              itemBuilder: (context, index) {
                var produto =
                    produtosFiltrados[index]; // Produto atual da lista.
                return ListTile(
                  title: Text(produto.nome), // Nome do produto.
                  subtitle: Text(produto.descricao), // Descrição do produto.
                  trailing: Text('R\$ ${produto.preco}'), // Preço do produto.
                  onTap: () {
                    // Ao clicar no produto, navega para a tela de detalhes do produto.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoScreen(
                          produto: produto, // Passa o produto selecionado.
                          adicionarCarrinho:
                              adicionarCarrinho, // Passa a função para adicionar ao carrinho.
                          carrinho: carrinho, // Passa o carrinho atual.
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
