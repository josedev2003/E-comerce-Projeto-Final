
import 'database_helper.dart';
import '../models/cliente.dart';

class ClienteDAO {
  Future<int> insertCliente(Cliente cliente) async {
    final db = await DatabaseHelper().db;
    return await db.insert('cliente', cliente.toMap());
  }

  Future<List<Cliente>> getClientes() async {
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> result = await db.query('cliente');
    return result.map((map) => Cliente.fromMap(map)).toList();
  }

  Future<int> updateCliente(Cliente cliente) async {
    final db = await DatabaseHelper().db;
    return await db.update('cliente', cliente.toMap(), where: 'id = ?', whereArgs: [cliente.id]);
  }

  Future<int> deleteCliente(int id) async {
    final db = await DatabaseHelper().db;
    return await db.delete('cliente', where: 'id = ?', whereArgs: [id]);
  }
}
