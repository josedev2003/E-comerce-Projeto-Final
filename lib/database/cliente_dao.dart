import 'package:e_commerce/database/database_helper.dart';
import '../models/cliente.dart';

class ClienteDAO {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertCliente(Cliente cliente) async {
    final db = await _databaseHelper.db;
    await db.insert('cliente', cliente.toMap());
  }

   Future<Cliente?> getClienteByEmail(String email) async {
    try {
      final db = await _databaseHelper.db;
      final List<Map<String, dynamic>> maps = await db.query(
        'cliente',
        where: 'email = ?',
        whereArgs: [email],
      );

      if (maps.isNotEmpty) {
        return Cliente.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('Erro ao buscar cliente: $e');
      return null; // Retorna null ou lanço uma exceção personalizada
    }
  }
}
