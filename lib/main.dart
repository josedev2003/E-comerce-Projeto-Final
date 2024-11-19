import 'package:e_commerce/database/database_helper.dart';
import 'package:e_commerce/screens/loginpage_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Apenas inicializar o banco de dados sem excluir
  await DatabaseHelper().db; // Garante a inicialização e atualização do banco

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: LoginScreen(),
    );
  }
}
