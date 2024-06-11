import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pind_app/src/features/customers/interactor/events/client_event.dart';
import 'package:pind_app/src/features/customers/interactor/repositories/client_repository.dart';
import 'package:pind_app/src/features/customers/interactor/states/client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository repository;

  ClientBloc(this.repository) : super(const LoadingClientState()) {
    on<AddClientEvent>(_addClientEvent);
    on<UpdateClientEvent>(_updateClientEvent);
    on<RemoveClientEvent>(_removeClientEvent);
    on<GetAllClientsEvent>(_getAllClientsEvent);
  }

  void _addClientEvent(AddClientEvent event, Emitter<ClientState> emit) async {
    emit(const LoadingClientState());
    try {
      repository.addClient(event.client);
      final clients = await repository.getAllClients();
      emit(clients);
    } catch (e) {
      emit(ErrorClientState(e.toString()));
    }
  }

  void _updateClientEvent(
      UpdateClientEvent event, Emitter<ClientState> emit) async {
    emit(const LoadingClientState());
    try {
      repository.editClient(event.id, event.updatedClient);
      final clients = await repository.getAllClients();
      emit(clients);
    } catch (e) {
      emit(ErrorClientState(e.toString()));
    }
  }

  void _removeClientEvent(
      RemoveClientEvent event, Emitter<ClientState> emit) async {
    emit(const LoadingClientState());
    try {
      repository.removeClient(event.id);
      final clients = await repository.getAllClients();
      emit(clients);
    } catch (e) {
      emit(ErrorClientState(e.toString()));
    }
  }

  void _getAllClientsEvent(
      GetAllClientsEvent event, Emitter<ClientState> emit) async {
    emit(const LoadingClientState());
    final newState = await repository.getAllClients();
    emit(newState);
  }
}
