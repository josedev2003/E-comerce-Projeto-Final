class Cliente {
  int? id;
  String nome;
  String cpf;
  String endereco;
  String email;
  String senha; // Adicionando o campo senha

  Cliente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.endereco,
    required this.email,
    required this.senha, // Adicionando o parâmetro senha
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'endereco': endereco,
      'email': email,
      'senha': senha, // Adicionando a senha ao mapa
    };
  }

  static Cliente fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nome: map['nome'],
      cpf: map['cpf'],
      endereco: map['endereco'],
      email: map['email'],
      senha: map['senha'], // Adicionando a senha ao objeto Cliente
    );
  }
}
