
import 'database_helper.dart';
import '../models/pedido.dart';

class PedidoDAO {
  Future<int> insertPedido(Pedido pedido) async {
    final db = await DatabaseHelper().db;
    return await db.insert('pedidos', pedido.toMap());
  }

  Future<List<Pedido>> getPedidos() async {
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> result = await db.query('pedidos');
    return result.map((map) => Pedido.fromMap(map)).toList();
  }

  Future<int> updatePedido(Pedido pedido) async {
    final db = await DatabaseHelper().db;
    return await db.update('pedidos', pedido.toMap(), where: 'id = ?', whereArgs: [pedido.id]);
  }

  Future<int> deletePedido(int id) async {
    final db = await DatabaseHelper().db;
    return await db.delete('pedidos', where: 'id = ?', whereArgs: [id]);
  }
}
