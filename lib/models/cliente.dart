class Cliente {
  int? id;
  String nome;
  String cpf;
  String endereco;
  String email;

  Cliente({this.id, required this.nome, required this.cpf, required this.endereco, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'endereco': endereco,
      'email': email,
    };
  }

  static Cliente fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nome: map['nome'],
      cpf: map['cpf'],
      endereco: map['endereco'],
      email: map['email'],
    );
  }
}
