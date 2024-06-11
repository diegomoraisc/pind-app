import 'package:pind_app/src/features/customers/interactor/entities/client_entity.dart';

sealed class ClientEvent {
  const ClientEvent();
}

class AddClientEvent implements ClientEvent {
  final ClientEntity client;

  AddClientEvent({
    required this.client,
  });
}

class UpdateClientEvent implements ClientEvent {
  final String id;
  final ClientEntity updatedClient;

  UpdateClientEvent({
    required this.id,
    required this.updatedClient,
  });
}

class RemoveClientEvent implements ClientEvent {
  final String id;

  RemoveClientEvent({
    required this.id,
  });
}

class GetAllClientsEvent implements ClientEvent {}
