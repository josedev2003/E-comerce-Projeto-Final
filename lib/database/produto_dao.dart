
import 'database_helper.dart';
import '../models/produto.dart';

class ProdutoDAO {
  Future<int> insertProduto(Produto produto) async {
    final db = await DatabaseHelper().db;
    return await db.insert('produto', produto.toMap());
  }

  Future<List<Produto>> getProdutos() async {
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> result = await db.query('produto');
    return result.map((map) => Produto.fromMap(map)).toList();
  }

  Future<int> updateProduto(Produto produto) async {
    final db = await DatabaseHelper().db;
    return await db.update('produto', produto.toMap(), where: 'id = ?', whereArgs: [produto.id]);
  }

  Future<int> deleteProduto(int id) async {
    final db = await DatabaseHelper().db;
    return await db.delete('produto', where: 'id = ?', whereArgs: [id]);
  }
}
