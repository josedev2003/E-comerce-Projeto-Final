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
      version: 36, // Atualize a versão sempre que mudar a estrutura
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
      if (oldVersion < 36) {
        // Exemplo de upgrade: Adicionando uma nova coluna
        await db.execute('''ALTER TABLE produto ADD COLUMN nova_coluna TEXT''');
        print("Banco atualizado para versão 36: Nova coluna adicionada.");
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
          'descricao': 'Chuteira leve e durável, ideal para jogadores que valorizam agilidade e conforto em campo.',
          'preco': 850.00,
          'categoria_id': 1,
          'image_path': 'assets/images/Chuteira Nike Legend 9 Elite.png'
        });
        await db.insert('produto', {
          'nome': 'Chuteira Nike Mercurial Vapor 14',
          'descricao': 'Chuteira de alta performance, projetada para velocidade e tração excepcional em gramados.',
          'preco': 900.00,
          'categoria_id': 1,
          'image_path': 'assets/images/Chuteira Nike Mercurial Vapor 14.png'
        });
        await db.insert('produto', {
          'nome': 'Chuteira Nike Phantom GX II - Preta e Branca',
          'descricao': 'Design moderno e controle aprimorado, ideal para jogadores criativos no ataque.',
          'preco': 920.00,
          'categoria_id': 1,
          'image_path': 'assets/images/Chuteira Nike Phantom GX II - Preta e Branca.png'
        });
        await db.insert('produto', {
          'nome': 'Chuteira Nike Phantom GX II - Preta',
          'descricao': 'Controle e precisão incomparáveis para os melhores momentos em campo.',
          'preco': 920.00,
          'categoria_id': 1,
          'image_path': 'assets/images/Chuteira Nike Phantom GX II - Preta.png'
        });
        await db.insert('produto', {
          'nome': 'Chuteira Nike Zoom Vapor 16',
          'descricao': 'Tecnologia Zoom Air para máxima resposta e velocidade nos gramados.',
          'preco': 930.00,
          'categoria_id': 1,
          'image_path': 'assets/images/Chuteira Nike Zoom Vapor 16.png'
        });
        await db.insert('produto', {
          'nome': 'Chuteira Nike Street Gato',
          'descricao': 'Desempenho e estilo para futsal, com solado aderente e amortecimento confortável.',
          'preco': 600.00,
          'categoria_id': 2,
          'image_path': 'assets/images/Chuteira Nike Street Gato.png'
        });
        await db.insert('produto', {
          'nome': 'Chuteira Nike Tiempo 10 - Azul',
          'descricao': 'Conforto e durabilidade, ideal para jogadores que buscam maior estabilidade.',
          'preco': 700.00,
          'categoria_id': 2,
          'image_path': 'assets/images/Chuteira Nike Tiempo 10 - Azul.png'
        });
        await db.insert('produto', {
          'nome': 'Chuteira Nike Tiempo 10 - Branca',
          'descricao': 'Modelo clássico e versátil, perfeito para todas as posições em quadra.',
          'preco': 700.00,
          'categoria_id': 2,
          'image_path': 'assets/images/Chuteira Nike Tiempo 10 - Branca.png'
        });
        await db.insert('produto', {
          'nome': 'Chuteira Nike Tiempo 10 - Preto',
          'descricao': 'Chuteira que combina resistência e conforto para partidas intensas.',
          'preco': 700.00,
          'categoria_id': 2,
          'image_path': 'assets/images/Chuteira Nike Tiempo 10 - Preto.png'
        });
        await db.insert('produto', {
          'nome': 'Chuteira Nike Tiempo 10 - Rosa',
          'descricao': 'Estilo vibrante com tecnologia de amortecimento para máxima performance.',
          'preco': 700.00,
          'categoria_id': 2,
          'image_path': 'assets/images/Chuteira Nike Tiempo 10 - Rosa.png'
        });
        await db.insert('produto', {
          'nome': 'Meia Unissex Branca',
          'descricao': 'Confortável e respirável, ideal para treinos e competições.',
          'preco': 30.00,
          'categoria_id': 3,
          'image_path': 'assets/images/Meia Unissex Branca.png'
        });
        await db.insert('produto', {
          'nome': 'Bolsa Nike Academy Team',
          'descricao': 'Bolsa espaçosa e prática para transportar seus equipamentos com estilo.',
          'preco': 120.00,
          'categoria_id': 3,
          'image_path': 'assets/images/Bolsa Nike Academy Team.png'
        });
        await db.insert('produto', {
          'nome': 'Camiseta Básica Branca',
          'descricao': 'Camiseta confortável e leve, ideal para o dia a dia ou treinos.',
          'preco': 50.00,
          'categoria_id': 3,
          'image_path': 'assets/images/Camiseta Básica Branca.png'
        });
        await db.insert('produto', {
          'nome': 'Camiseta Basica Preta',
          'descricao': 'Modelo versátil, perfeito para treinos ou uso casual.',
          'preco': 50.00,
          'categoria_id': 3,
          'image_path': 'assets/images/Camiseta Basica Preta.png'
        });
        await db.insert('produto', {
          'nome': 'Caneleira J Guard',
          'descricao': 'Proteção leve e eficiente para maior segurança durante o jogo.',
          'preco': 40.00,
          'categoria_id': 3,
          'image_path': 'assets/images/Caneleira J Guard.png'
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
      print('Erro ao inserir dados iniciais: $e\nStackTrace: ${StackTrace.current}');
    }
  }
}
