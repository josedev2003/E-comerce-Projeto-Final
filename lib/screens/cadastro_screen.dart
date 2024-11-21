import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_commerce/database/cliente_dao.dart';
import '../models/cliente.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _cpf = '';
  String _endereco = '';
  String _email = '';
  String _senha = '';
  bool _senhaVisivel = false; // Para controlar a visibilidade da senha

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      final cliente = Cliente(
        nome: _nome,
        cpf: _cpf,
        endereco: _endereco,
        email: _email,
        senha: _senha,
      );

      await ClienteDAO().insertCliente(cliente);
      Navigator.pop(context); // Navegar para outra tela ou feedback de sucesso
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfff6fcdf),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Logo no topo
                Image.asset(
                  'assets/images/Logo.png', // Atualize o caminho da logo
                  height: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),

                // Título
                Text(
                  "Crie sua Conta",
                  style: TextStyle(
                    fontFamily: "Prata",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1a1a19),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Preencha os campos abaixo para começar sua jornada!",
                  style: TextStyle(
                    fontFamily: "Prata",
                    fontSize: 14,
                    color: Color(0xff1a1a19),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // Formulário
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        label: 'Nome',
                        onChanged: (value) => _nome = value,
                        validator: (value) {
                          if (value!.isEmpty) return 'Por favor, insira seu nome.';
                          if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value)) {
                            return 'O nome deve conter apenas letras.';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        label: 'CPF',
                        onChanged: (value) => _cpf = value,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          _CpfInputFormatter(), // Custom formatter para CPF
                        ],
                        validator: (value) {
                          if (value!.isEmpty) return 'Por favor, insira seu CPF.';
                          if (value.length != 14) return 'CPF deve ter 11 dígitos.';
                          return null;
                        },
                      ),
                      _buildTextField(
                        label: 'Endereço',
                        onChanged: (value) => _endereco = value,
                        validator: (value) {
                          if (value!.isEmpty) return 'Por favor, insira seu endereço.';
                          return null;
                        },
                      ),
                      _buildTextField(
                        label: 'Email',
                        onChanged: (value) => _email = value,
                        validator: (value) {
                          if (value!.isEmpty) return 'Por favor, insira seu email.';
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Email inválido.';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        label: 'Senha',
                        onChanged: (value) => _senha = value,
                        obscureText: !_senhaVisivel,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _senhaVisivel = !_senhaVisivel;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return 'Por favor, insira sua senha.';
                          if (value.length < 6) return 'A senha deve ter pelo menos 6 caracteres.';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Botão de cadastro
                ElevatedButton(
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xff1a1a19),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Prata",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    required String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: "Prata",
            color: Color(0xff1a1a19),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xff1a1a19), width: 1.5),
          ),
          suffixIcon: suffixIcon,
        ),
        onChanged: onChanged,
        validator: validator,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        style: TextStyle(
          fontFamily: "Prata",
          fontSize: 16,
          color: Color(0xff1a1a19),
        ),
      ),
    );
  }
}

class _CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) buffer.write('.');
      if (i == 9) buffer.write('-');
      buffer.write(text[i]);
    }
    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}