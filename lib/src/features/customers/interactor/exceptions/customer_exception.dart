sealed class CustomerException implements Exception {
  final String message;
  const CustomerException(this.message);
}

class EmptyListException extends CustomerException {
  const EmptyListException() : super('Nenhum cliente encontrado');
}

class UnknownException extends CustomerException {
  const UnknownException() : super('Erro desconhecido');
}
