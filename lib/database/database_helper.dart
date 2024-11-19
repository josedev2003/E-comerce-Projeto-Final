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
    print("Path do banco de dados: $path"); // Log do caminho do banco
    return await openDatabase(
      path,
      version: 33, // Atualize a versão sempre que mudar a estrutura
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Criação das tabelas no banco de dados
  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''CREATE TABLE categoria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT
      );''');

      await db.execute('''CREATE TABLE produto (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        descricao TEXT,
        preco REAL,
        categoria_id INTEGER,
        image_path TEXT, 
        FOREIGN KEY(categoria_id) REFERENCES categoria(id)
      );''');

      await db.execute('''CREATE TABLE cliente (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        cpf TEXT,
        endereco TEXT,
        email TEXT UNIQUE,
        senha TEXT NOT NULL
      );''');

      await db.execute('''CREATE TABLE estoque (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        produto_id INTEGER,
        quantidadeDisponivel INTEGER NOT NULL, 
        FOREIGN KEY(produto_id) REFERENCES produto(id)
      );''');

      await _inserirDadosIniciais(db);
      print("Tabelas criadas e dados iniciais inseridos.");
    } catch (e) {
      print('Erro ao criar tabelas: $e');
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      if (oldVersion < 33) {
        // Exemplo de upgrade: Adicionando uma nova coluna
        await db.execute('''ALTER TABLE produto ADD COLUMN nova_coluna TEXT''');
        print("Banco atualizado para versão 33: Nova coluna adicionada.");
      }
    } catch (e) {
      print('Erro ao atualizar o banco de dados: $e');
    }
  }

  Future<void> _inserirDadosIniciais(Database db) async {
    try {
      // Inserir categorias apenas se não existirem
      var categorias = await db.query('categoria');
      if (categorias.isEmpty) {
        await db.insert('categoria', {'nome': 'Chuteiras'});
        await db.insert('categoria', {'nome': 'Tênis de Futsal'});
        await db.insert('categoria', {'nome': 'Acessórios'});
        print("Categorias inseridas com sucesso.");
      } else {
        print("Categorias já existem.");
      }

      // Inserir produtos apenas se não existirem
      var produtos = await db.query('produto');
      if (produtos.isEmpty) {
        await db.insert('produto', {
          'nome': 'Chuteira Nike Legend 9 Elite',
          'descricao':
              'Modelo premium, ideal para jogadores que buscam controle e precisão nos chutes.',
          'preco': 950.00,
          'categoria_id': 1,
          'image_path': 'assets/images/Chuteira Nike Legend 9 Elite.png'
        });
        // Outros produtos podem ser inseridos aqui...
        print("Produtos inseridos com sucesso.");
      } else {
        print("Produtos já existem.");
      }

      // Inserir estoques apenas se não existirem
      var estoques = await db.query('estoque');
      if (estoques.isEmpty) {
        await db.insert('estoque', {'produto_id': 1, 'quantidadeDisponivel': 10});
        // Outros estoques podem ser inseridos aqui...
        print("Estoque inicial inserido com sucesso.");
      } else {
        print("Estoque já existe.");
      }
    } catch (e) {
      print('Erro ao inserir dados iniciais: $e');
    }
  }
}
