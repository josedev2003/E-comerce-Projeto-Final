
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
            title: 'Encontre o par perfeito para você!',
            text:
                'Nossas chuteiras foram projetadas para proporcionar aderência, conforto e controle excepcionais. Eleve seu jogo e destaque-se em campo com estilo e performance!',
            backgroundColor: Colors.blueAccent.withOpacity(0.5),
          ),
          _buildPage(
            image: 'assets/images/tenis-futsal.png',
            title: 'Futsal com estilo e conforto',
            text:
                'Os nossos tênis de futsal oferecem a combinação ideal de leveza e tração, permitindo que você se mova rapidamente e com agilidade em quadra. Prepare-se para dominar a partida!',
            backgroundColor: Colors.greenAccent.withOpacity(0.5),
          ),
          _buildPage(
            image: 'assets/images/caneleira.png',
            title: 'Complete seu kit com qualidade',
            text:
                'Nossos acessórios de futebol foram escolhidos para garantir que você esteja sempre preparado em campo. Mostre seu amor pelo futebol e jogue com confiança e segurança!',
            backgroundColor: Colors.orangeAccent.withOpacity(0.5),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _prevPage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                side: BorderSide(color: Colors.white),
              ),
              child: Text('Retornar'),
            ),
            ElevatedButton(
              onPressed: _initialPage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                side: BorderSide(color: Colors.white),
              ),
              child: Text("Pular"),
            ),
            ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                side: BorderSide(color: Colors.white),
              ),
              child: Text("Avançar"),
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
    required Color backgroundColor,
  }) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo no topo
            Image.asset(
              'assets/images/logo.png', // Caminho para sua logo
              height: 100,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 0), // Espaço entre a logo e o nome
            Text(
              'Golaço',
              style: TextStyle(
                fontFamily: "Prata",
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Espaço entre o nome e a imagem do produto
            Image.asset(
              image,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontFamily: "Prata",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
                  color: Colors.white,
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
