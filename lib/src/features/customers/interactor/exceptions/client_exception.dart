sealed class ClientException implements Exception {
  final String message;
  const ClientException(this.message);
}

class EmptyListException extends ClientException {
  const EmptyListException() : super('Nenhum cliente encontrado');
}

class UnknownException extends ClientException {
  const UnknownException() : super('Erro desconhecido');
}
