import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/common/database/firestore_db.dart';
import 'package:pind_app/src/features/customers/data/adapters/client_adapter.dart';
import 'package:pind_app/src/features/customers/interactor/entities/client_entity.dart';
import 'package:pind_app/src/features/customers/interactor/exceptions/client_exception.dart';
import 'package:pind_app/src/features/customers/interactor/repositories/client_repository.dart';
import 'package:pind_app/src/features/customers/interactor/states/client_state.dart';

class ClientDbRepository implements ClientRepository {
  final clientsCollection = FirestoreDb.get().collection("clients");

  @override
  Future<ClientState> addClient(ClientEntity newClient) async {
    try {
      final client = ClientAdapter.toMap(newClient);
      final docRef = await clientsCollection.add(client);

      final addedClient = newClient.copyWith(id: docRef.id);

      return LoadedClientState([addedClient]);
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<ClientState> editClient(String id, ClientEntity updatedClient) async {
    try {
      final client = ClientAdapter.toMap(updatedClient);
      await clientsCollection.doc(id).update(client);
      return UpdatedClientState(id, updatedClient);
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<ClientState> getAllClients() async {
    try {
      QuerySnapshot querySnapshot = await clientsCollection.get();

      if (querySnapshot.docs.isEmpty) {
        return ErrorClientState(const EmptyListException().message);
      }

      List<ClientEntity> clients = [];
      for (var doc in querySnapshot.docs) {
        final client =
            ClientAdapter.fromMap(doc.data() as Map<String, dynamic>);

        clients.add(client.copyWith(id: doc.id));
      }
      return LoadedClientState(clients);
    } catch (e) {
      return ErrorClientState(const UnknownException().message);
    }
  }

  @override
  Future<ClientState> removeClient(String id) async {
    try {
      await clientsCollection.doc(id).delete();
      return RemovedClientState(id);
    } catch (e) {
      throw const UnknownException();
    }
  }
}
