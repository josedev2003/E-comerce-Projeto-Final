
import 'database_helper.dart';
import '../models/pagamento.dart';

class PagamentoDAO {
  Future<int> insertPagamento(Pagamento pagamento) async {
    final db = await DatabaseHelper().db;
    return await db.insert('pagamento', pagamento.toMap());
  }

  Future<List<Pagamento>> getPagamentos() async {
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> result = await db.query('pagamento');
    return result.map((map) => Pagamento.fromMap(map)).toList();
  }

  Future<int> updatePagamento(Pagamento pagamento) async {
    final db = await DatabaseHelper().db;
    return await db.update('pagamento', pagamento.toMap(), where: 'id = ?', whereArgs: [pagamento.id]);
  }

  Future<int> deletePagamento(int id) async {
    final db = await DatabaseHelper().db;
    return await db.delete('pagamento', where: 'id = ?', whereArgs: [id]);
  }
}
