sealed class ProductException implements Exception {
  final String message;
  const ProductException(this.message);
}

class EmptyListException extends ProductException {
  const EmptyListException() : super('Nenhum produto encontrado');
}

class UnknownException extends ProductException {
  const UnknownException() : super('Erro desconhecido');
}
