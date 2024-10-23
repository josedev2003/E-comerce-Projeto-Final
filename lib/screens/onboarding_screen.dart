import 'package:e_commerce/database/categoria_dao.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../models/categoria.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> categorias = [];
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    carregarCategorias();
  }

  void carregarCategorias() async {
    CategoriaDAO categoriaDAO = CategoriaDAO();
    List<Categoria> categoriasExistentes = await categoriaDAO.getCategorias();

    if (categoriasExistentes.isEmpty) {
      await categoriaDAO.insertCategoria(Categoria(nome: 'Categoria 1'));
      await categoriaDAO.insertCategoria(Categoria(nome: 'Categoria 2'));
      categoriasExistentes = await categoriaDAO.getCategorias();
    }

    setState(() {
      categorias =
          categoriasExistentes.map((categoria) => categoria.nome).toList();
    });

    print("Categorias carregadas: $categorias");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          _buildPage(
            image: 'assets/images/tenis-futsal.png',
            title: 'Explore nossos incríveis tênis!',
            backgroundColor: Colors.blueAccent,
          ),
          _buildPage(
            image: 'assets/images/chuteira.png',
            title: 'Encontre o par perfeito para você!',
            backgroundColor: Colors.greenAccent,
          ),
          _buildPage(
            image: 'assets/images/caneleira.png',
            title: 'Qualidade e conforto em cada passo!',
            backgroundColor: Colors.orangeAccent,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(categorias: categorias)),
            );
          },
          child: Text('Começar'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildPage({
    required String
        image, // Mudança para receber uma String com o caminho da imagem
    required String title,
    required Color backgroundColor,
  }) {
    return Container(
      color: backgroundColor, // Define a cor de fundo da página
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image, // Usando o caminho da imagem diretamente
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors
                    .white, // O texto pode ser ajustado para se destacar sobre o fundo
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
