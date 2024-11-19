import 'package:e_commerce/database/cliente_dao.dart';
import 'package:flutter/material.dart';
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
  // ignore: unused_field
  String _senha = '';

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      final cliente = Cliente(
        nome: _nome,
        cpf: _cpf,
        endereco: _endereco,
        email: _email, 
        senha: '',
      );

      await ClienteDAO().insertCliente(cliente);
      // Navegue para a tela de login ou faça o que precisar após o cadastro
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) => _nome = value,
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor, insira seu nome.';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CPF'),
                onChanged: (value) => _cpf = value,
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor, insira seu CPF.';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Endereço'),
                onChanged: (value) => _endereco = value,
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor, insira seu endereço.';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => _email = value,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) return 'Por favor, insira um email válido.';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                onChanged: (value) => _senha = value,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Por favor, insira sua senha.';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _cadastrar,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
