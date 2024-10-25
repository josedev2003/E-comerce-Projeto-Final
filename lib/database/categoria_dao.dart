import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import '../models/categoria.dart';

class CategoriaDAO {
  Future<void> initializeCategorias(List<Categoria> categoriasIniciais) async {
    final db = await DatabaseHelper().db;

    // Verifica se a tabela categoria já possui dados
    final List<Map<String, dynamic>> existingCategorias = await db.query('categoria');

    // Insere as categorias iniciais apenas se a tabela estiver vazia
    if (existingCategorias.isEmpty) {
      for (Categoria categoria in categoriasIniciais) {
        await db.insert(
          'categoria',
          categoria.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
      // ignore: avoid_print
      print('Categorias iniciais inseridas.');
    } else {
      // ignore: avoid_print
      print('Categorias já existentes no banco de dados.');
    }
  }

  Future<List<Categoria>> getCategorias() async {
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> result = await db.query('categoria');

    // ignore: avoid_print
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
