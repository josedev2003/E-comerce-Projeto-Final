import 'package:flutter/material.dart';
import '../models/cliente.dart';


class UserScreen extends StatelessWidget {
  final Cliente cliente;

  const UserScreen({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6fcdf),
      appBar: AppBar(
        backgroundColor: Color(0xff1a1a19),
        title: Text(
          "Perfil do Cliente",
          style: TextStyle(
            fontFamily: "Prata",
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saudação e ícone de perfil
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xff1a1a19),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bem-vindo, ${cliente.nome}!",
                    style: TextStyle(
                      fontFamily: "Prata",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1a1a19),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Informações do cliente
            _buildInfoRow("Nome:", cliente.nome),
            _buildInfoRow("CPF:", cliente.cpf),
            _buildInfoRow("Endereço:", cliente.endereco),
            _buildInfoRow("Email:", cliente.email),
            

            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label ",
            style: TextStyle(
              fontFamily: "Prata",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff1a1a19),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: "Prata",
                fontSize: 16,
                color: Color(0xff1a1a19),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
