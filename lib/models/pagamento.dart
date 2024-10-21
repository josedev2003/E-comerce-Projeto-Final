class Pagamento {
  int id;
  double valor;
  String status;

  Pagamento({
    required this.id,
    required this.valor,
    required this.status,
  });

  void processarPagamento() {
    status = 'Pago';
  }
}
