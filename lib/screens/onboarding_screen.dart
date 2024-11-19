import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> categorias = [];
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    //carregarCategorias();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(categorias: categorias)),
      );
    }
  }

  void _prevPage() {
    _pageController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  }

  void _initialPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(categorias: categorias),
      ),
    );
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
            image: 'assets/images/chuteira.png',
            title: 'O par perfeito para você!',
            text:
                'Nossas chuteiras foram projetadas para proporcionar aderência, conforto e controle excepcionais. Eleve seu jogo e destaque-se em campo com estilo e performance!',
          ),
          _buildPage(
            image: 'assets/images/tenis-futsal.png',
            title: 'Futsal com estilo e conforto',
            text:
                'Os nossos tênis de futsal oferecem a combinação ideal de leveza e tração, permitindo que você se mova rapidamente e com agilidade em quadra. Prepare-se para dominar a partida!',
          ),
          _buildPage(
            image: 'assets/images/Nike_Caneleira.png',
            title: 'Complete seu kit com qualidade',
            text:
                'Nossos acessórios de futebol foram escolhidos para garantir que você esteja sempre preparado em campo. Mostre seu amor pelo futebol e jogue com confiança e segurança!',
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(0xfff6fcdf),
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: _prevPage,
              child: Text('Retornar', style: TextStyle(color: Color(0xff1a1a19)),),
            ),
            TextButton(
              onPressed: _initialPage,
              child: Text("Pular",  style: TextStyle(color: Color(0xff1a1a19))),
            ),
            TextButton(
              onPressed: _nextPage,
              child: Text("Avançar",  style: TextStyle(color: Color(0xff1a1a19))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String text,
  }) {
    return Container(
      color: Color(0xfff6fcdf),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo no topo
            Image.asset(
              'assets/images/Logo.png', // Caminho para sua logo
              height: 100,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 0), // Espaço entre a logo e o nome
            SizedBox(height: 20), // Espaço entre o nome e a imagem do produto
            Image.asset(
              image,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontFamily: "Prata",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff1a1a19),
              ),
              textAlign: TextAlign.center,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: "Prata",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff1a1a19),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
