import 'database_helper.dart';
import '../models/produto.dart';
import '../models/estoque.dart';

class ProdutoDAO {
  // Insere um produto no banco de dados e adiciona a quantidade inicial de estoque
  Future<int> insertProduto(Produto produto, int quantidadeInicial) async {
    final db = await DatabaseHelper().db;
    print('Inserindo produto: ${produto.toMap()}');
    
    // Insere o produto e recupera o id inserido
    int produtoId = await db.insert('produto', produto.toMap());

    // Cria o objeto Estoque com a quantidade inicial e o id do produto
    Estoque estoque = Estoque(
      produto: produto,
      quantidadeDisponivel: quantidadeInicial,
    );

    // Adiciona o estoque do produto
    await addEstoque(estoque);

    return produtoId;
  }

  // Método para adicionar a quantidade inicial de estoque para um produto
  Future<void> addEstoque(Estoque estoque) async {
    final db = await DatabaseHelper().db;
    await db.insert('estoque', estoque.toMap());
  }

  // Método para atualizar a quantidade de estoque de um produto específico
  Future<void> updateEstoque(int produtoId, int novaQuantidade) async {
    final db = await DatabaseHelper().db;
    await db.update(
      'estoque',
      {'quantidade': novaQuantidade},
      where: 'produto_id = ?',
      whereArgs: [produtoId],
    );
  }

  // Método para obter a quantidade de estoque de um produto específico
  Future<int> getEstoque(int produtoId) async {
    final db = await DatabaseHelper().db;
    final result = await db.query(
      'estoque',
      columns: ['quantidade'],
      where: 'produto_id = ?',
      whereArgs: [produtoId],
    );

    if (result.isNotEmpty) {
      return result.first['quantidade'] as int;
    }
    return 0; // Retorna 0 se o produto não tiver estoque registrado
  }

  // Recupera a lista de produtos
  Future<List<Produto>> getProdutos() async {
    final db = await DatabaseHelper().db;
    final List<Map<String, dynamic>> result = await db.query('produto');
    
    print('Produtos recuperados: $result');
    return result.map((map) => Produto.fromMap(map)).toList();
  }

  // Atualiza um produto existente
  Future<int> updateProduto(Produto produto) async {
    final db = await DatabaseHelper().db;
    return await db.update(
      'produto',
      produto.toMap(),
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  // Deleta um produto pelo ID e remove seu estoque correspondente
  Future<int> deleteProduto(int id) async {
    final db = await DatabaseHelper().db;

    // Remove o estoque associado ao produto antes de deletar o produto
    await db.delete(
      'estoque',
      where: 'produto_id = ?',
      whereArgs: [id],
    );

    return await db.delete(
      'produto',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
