import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  // Getter para o banco de dados
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  DatabaseHelper._internal();

  // Inicializa o banco de dados
  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), "modgeek.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Adiciona um método para upgrade se necessário
    );
  }

  // Cria as tabelas no banco de dados
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categoria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE produto (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        descricao TEXT,
        preco REAL,
        categoria_id INTEGER,
        FOREIGN KEY(categoria_id) REFERENCES categoria(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE estoque (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        produto_id INTEGER,
        quantidade INTEGER,
        FOREIGN KEY(produto_id) REFERENCES produto(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE cliente (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        cpf TEXT,
        endereco TEXT,
        email TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE carrinho (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cliente_id INTEGER,
        total REAL,
        FOREIGN KEY(cliente_id) REFERENCES cliente(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE item_carrinho (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        produto_id INTEGER,
        carrinho_id INTEGER,
        quantidade INTEGER,
        preco_total REAL,
        FOREIGN KEY(produto_id) REFERENCES produto(id),
        FOREIGN KEY(carrinho_id) REFERENCES carrinho(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE pedidos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cliente_id INTEGER,
        carrinho_id INTEGER,
        status TEXT,
        FOREIGN KEY(cliente_id) REFERENCES cliente(id),
        FOREIGN KEY(carrinho_id) REFERENCES carrinho(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE pagamento (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo TEXT,
        status TEXT,
        pedido_id INTEGER,
        FOREIGN KEY(pedido_id) REFERENCES pedidos(id)
      );
    ''');

  }

  // Método para atualizar o banco de dados se necessário
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Adicione lógica de upgrade aqui, se necessário
  }

  // Função para excluir o banco de dados
  // Função para excluir o banco de dados
  Future<void> dropDatabase() async {
    String path = join(await getDatabasesPath(), 'modgeek.db');
    await deleteDatabase(path); // Exclui o banco de dados
  }
}


