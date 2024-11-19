import 'package:e_commerce/database/cliente_dao.dart';
import 'package:e_commerce/screens/cadastro_screen.dart';
import 'package:e_commerce/screens/onboarding_screen.dart'; // Import da OnboardingScreen
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _senha = '';

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final cliente = await ClienteDAO().getClienteByEmail(_email);

      if (cliente != null) {
        if (cliente.senha == _senha) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Login bem-sucedido!')));
          // Navega para a tela de Onboarding
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Senha incorreta!')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Cliente não encontrado!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6fcdf),
      body: Center(
        child: SingleChildScrollView(
          // Permite rolagem caso o teclado apareça
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Mantém o tamanho mínimo do conteúdo
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset(
                      'assets/images/Logo.png',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Color(0xff1a1a19))
                    ),
                    style: TextStyle(color:  Color(0xff1a1a19)),
                    onChanged: (value) => _email = value,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Por favor, insira um email válido.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(color:  Color(0xff1a1a19))
                    ),
                    onChanged: (value) => _senha = value,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira sua senha.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xff1a1a19), 
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )

                    ),
                    onPressed: _login,
                    child: Text('Login', style: TextStyle(color: Color(0xfff6fcdf)),),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CadastroScreen()),
                      );
                    },
                    child: Text('Não tem uma conta? Cadastre-se'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
