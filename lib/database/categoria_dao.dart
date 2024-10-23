import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import '../models/categoria.dart';

class CategoriaDAO {
  Future<void> insertCategoria(Categoria categoria) async {
    final db = await DatabaseHelper().db;
    // Insira a categoria somente se não existir
    List<Map<String, dynamic>> existingCategorias = await db.query(
      'categoria',
      where: 'nome = ?',
      whereArgs: [categoria.nome],
    );

    if (existingCategorias.isEmpty) {
      await db.insert(
        'categoria',
        categoria.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Categoria>> getCategorias() async {
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> result = await db.query('categoria');

    print('Resultado da consulta: $result');

    return result.map((map) => Categoria.fromMap(map)).toList();
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
