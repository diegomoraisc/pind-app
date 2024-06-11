import 'package:pind_app/src/features/customers/interactor/entities/client_entity.dart';
import 'package:pind_app/src/features/customers/interactor/states/client_state.dart';

abstract class ClientRepository {
  Future<ClientState> addClient(ClientEntity newClient);

  Future<ClientState> editClient(String id, ClientEntity updatedClient);

  Future<ClientState> removeClient(String id);

  Future<ClientState> getAllClients();
}
