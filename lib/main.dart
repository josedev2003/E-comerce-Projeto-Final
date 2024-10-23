import 'package:e_commerce/database/database_helper.dart';
import 'package:e_commerce/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await DatabaseHelper().dropDatabase();

  // Obtenha a instância do banco de dados
  final db = await DatabaseHelper().db;

  runApp(const MyApp());
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
      ),
      home:  OnboardingScreen(),
    );
  }
}
