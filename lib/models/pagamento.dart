class Pagamento {
  int id;
  double valor;
  String status;

  Pagamento({
    required this.id,
    required this.valor,
    required this.status,
  });

  // Método para converter o objeto Pagamento em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valor': valor,
      'status': status,
    };
  }

  // Método para criar um objeto Pagamento a partir de um Map
  factory Pagamento.fromMap(Map<String, dynamic> map) {
    return Pagamento(
      id: map['id'],
      valor: map['valor'],
      status: map['status'],
    );
  }

  // Método que simula o processamento do pagamento
  void processarPagamento() {
    status = 'Pago';
  }
}
