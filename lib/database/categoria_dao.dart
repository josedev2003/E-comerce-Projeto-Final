
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';
import '../models/categoria.dart';

class CategoriaDAO {

Future<void> insertCategoria(Categoria categoria) async {
  final db = await DatabaseHelper().db;
  await db.insert(
    'categoria',
    categoria.toMap(), // Certifique-se de que você tenha um método toMap na classe Categoria.
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

  Future<List<Categoria>> getCategorias() async {
    final db = await DatabaseHelper().db; // Verifique se o banco de dados está aberto corretamente.
    final List<Map<String, dynamic>> result = await db.query('categoria');

    // ignore: avoid_print
    print('Resultado da consulta: $result'); 

    return result.map((map) => Categoria.fromMap(map)).toList(); // Verifique se `fromMap` está implementado corretamente.
  }


  Future<int> updateCategoria(Categoria categoria) async {
    final db = await DatabaseHelper().db;
    return await db.update('categoria', categoria.toMap(), where: 'id = ?', whereArgs: [categoria.id]);
  }

  Future<int> deleteCategoria(int id) async {
    final db = await DatabaseHelper().db;
    return await db.delete('categoria', where: 'id = ?', whereArgs: [id]);
  }
}
