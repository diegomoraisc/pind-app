sealed class OrderException implements Exception {
  final String message;
  const OrderException(this.message);
}

class EmptyListException extends OrderException {
  const EmptyListException() : super('Nenhum pedido encontrado');
}

class UnknownException extends OrderException {
  const UnknownException() : super('Erro desconhecido');
}
