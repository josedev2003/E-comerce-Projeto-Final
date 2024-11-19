import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import '../models/estoque.dart';
import '../models/produto.dart'; // Certifique-se de importar o Produto

class EstoqueDAO {
  // Método para inserir estoque
  Future<void> insertEstoque(Estoque estoque) async {
    final db = await DatabaseHelper().db;
    await db.insert(
      'estoque',
      estoque.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Método para atualizar estoque
  Future<void> updateEstoque(int produtoId, int novaQuantidade) async {
    final db = await DatabaseHelper().db;
    await db.update(
      'estoque',
      {'quantidadeDisponivel': novaQuantidade}, // Usando o nome correto da coluna
      where: 'produto_id = ?',
      whereArgs: [produtoId],
    );
  }

  // Método para recuperar o estoque de um produto
  Future<Estoque?> getEstoque(int produtoId) async {
    final db = await DatabaseHelper().db;
    List<Map<String, dynamic>> result = await db.query(
      'estoque',
      where: 'produto_id = ?',
      whereArgs: [produtoId],
    );
    
    if (result.isNotEmpty) {
      // Recuperando o Produto correspondente ao produto_id
      Produto produto = await _getProdutoById(produtoId);

      // Criando o Estoque com o Produto associado
      return Estoque.fromMap(result.first, produto);
    }
    return null;
  }

  // Método para recuperar o Produto com base no seu ID
  Future<Produto> _getProdutoById(int produtoId) async {
    final db = await DatabaseHelper().db;
    List<Map<String, dynamic>> result = await db.query(
      'produto',
      where: 'id = ?',
      whereArgs: [produtoId],
    );
    
    if (result.isNotEmpty) {
      return Produto.fromMap(result.first);
    }
    throw Exception('Produto não encontrado');
  }
}
