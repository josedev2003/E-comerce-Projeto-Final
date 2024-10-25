import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ecommerce.db');
    return await openDatabase(
      path,
      version: 2, // Aumente a versão aqui
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Adicione este método para gerenciar a atualização
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

    // Insere dados iniciais
    await db.insert('categoria', {'nome': 'Chuteiras'});
    await db.insert('categoria', {'nome': 'Tênis de Futsal'});
    await db.insert('categoria', {'nome': 'Acessórios'});

    await db.insert('produto', {'nome': 'Tênis Esportivo', 'descricao': 'Super tênis de corrida', 'preco': 150.00, 'categoria_id': 1});
    await db.insert('produto', {'nome': 'Tênis Casual', 'descricao': 'Tênis confortável para o dia a dia', 'preco': 120.00, 'categoria_id': 2});
    await db.insert('produto', {'nome': 'Bota de Aventura', 'descricao': 'Bota resistente para trilhas', 'preco': 300.00, 'categoria_id': 3});
  }

  // Método para atualizar o banco de dados
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Exclui tabelas existentes
    await db.execute('DROP TABLE IF EXISTS produto');
    await db.execute('DROP TABLE IF EXISTS categoria');
    
    // Cria as tabelas novamente
    await _onCreate(db, newVersion);
  }

  // Método para excluir o banco de dados
  Future<void> dropDatabase() async {
    String path = join(await getDatabasesPath(), 'ecommerce.db');
    await deleteDatabase(path); // Exclui o banco de dados
  }
}
