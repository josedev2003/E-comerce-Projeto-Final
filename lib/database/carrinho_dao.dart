import 'package:e_commerce/models/carrinho.dart';

import 'database_helper.dart';

class CarrinhoDAO {
  Future<int> insertCarrinho(CarrinhoDeCompras carrinho) async {
    final db = await DatabaseHelper().db;
    return await db.insert('carrinho', carrinho.toMap());
  }

  Future<List<CarrinhoDeCompras>> getCarrinhos() async {
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> result = await db.query('carrinho');
    return result.map((map) => CarrinhoDeCompras.fromMap(map)).toList();
  }

  Future<int> updateCarrinho(CarrinhoDeCompras carrinho) async {
    final db = await DatabaseHelper().db;
    return await db.update('carrinho', carrinho.toMap(), where: 'id = ?', whereArgs: [carrinho.id]);
  }

  Future<int> deleteCarrinho(int id) async {
    final db = await DatabaseHelper().db;
    return await db.delete('carrinho', where: 'id = ?', whereArgs: [id]);
  }
}
