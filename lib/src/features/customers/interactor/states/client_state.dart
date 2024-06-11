import 'package:pind_app/src/features/customers/interactor/entities/client_entity.dart';

sealed class ClientState {
  const ClientState();
}

class LoadingClientState implements ClientState {
  const LoadingClientState();
}

class AddedClientState implements ClientState {
  final ClientEntity client;

  const AddedClientState(this.client);
}

class UpdatedClientState implements ClientState {
  final String id;
  final ClientEntity updatedClient;

  UpdatedClientState(this.id, this.updatedClient);
}

class RemovedClientState implements ClientState {
  final String id;

  RemovedClientState(this.id);
}

class LoadedClientState implements ClientState {
  List<ClientEntity> clients;

  LoadedClientState(this.clients);
}

class ErrorClientState implements ClientState {
  final String message;

  ErrorClientState(this.message);
}
