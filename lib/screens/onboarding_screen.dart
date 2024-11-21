import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> categorias = [];
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradiente de fundo
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xfff6fcdf),
                  Color(0xffd8f3b3),
                ],
              ),
            ),
          ),
          // Conteúdo principal
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPage(
                image: 'assets/images/Chuteira Nike Legend 9 Elite.png',
                title: 'O par perfeito para você!',
                text:
                    'Nossas chuteiras foram projetadas para proporcionar aderência, conforto e controle excepcionais. Eleve seu jogo e destaque-se em campo com estilo e performance!',
              ),
              _buildPage(
                image: 'assets/images/Chuteira Nike Street Gato.png',
                title: 'Futsal com estilo e conforto',
                text:
                    'Os nossos tênis de futsal oferecem a combinação ideal de leveza e tração, permitindo que você se mova rapidamente e com agilidade em quadra. Prepare-se para dominar a partida!',
              ),
              _buildPage(
                image: 'assets/images/Bolsa Nike Academy Team.png',
                title: 'Complete seu kit com qualidade',
                text:
                    'Nossos acessórios de futebol foram escolhidos para garantir que você esteja sempre preparado em campo. Mostre seu amor pelo futebol e jogue com confiança e segurança!',
              ),
            ],
          ),
          // Indicadores e botões
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIndicators(),
                  const SizedBox(height: 10),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Logo.png',
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30),
          Image.asset(
            image,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontFamily: "Prata",
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xff1a1a19),
              shadows: [
                Shadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black26,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            text,
            style: const TextStyle(
              fontFamily: "Prata",
              fontSize: 16,
              color: Color(0xff1a1a19),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: _currentPage == index ? 12 : 8,
          height: _currentPage == index ? 12 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color(0xff1a1a19)
                : const Color(0xffd8f3b3),
            shape: BoxShape.circle,
            boxShadow: [
              if (_currentPage == index)
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton("Retornar", onTap: _prevPage),
        _buildButton("Pular", onTap: _initialPage),
        _buildButton("Avançar", onTap: _nextPage),
      ],
    );
  }

  Widget _buildButton(String text, {required VoidCallback onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: const Color(0xff1a1a19),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _initialPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(categorias: categorias)),
    );
  }
}
