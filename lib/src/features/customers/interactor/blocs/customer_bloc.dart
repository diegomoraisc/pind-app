import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pind_app/src/features/customers/interactor/events/customer_event.dart';
import 'package:pind_app/src/features/customers/interactor/repositories/client_repository.dart';
import 'package:pind_app/src/features/customers/interactor/states/customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository repository;

  CustomerBloc(this.repository) : super(const LoadingCustomerState()) {
    on<AddCustomerEvent>(_addCustomerEvent);
    on<UpdateCustomerEvent>(_updateCustomerEvent);
    on<RemoveCustomerEvent>(_removeCustomerEvent);
    on<GetAllCustomersEvent>(_getAllCustomersEvent);
  }

  void _addCustomerEvent(
      AddCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(const LoadingCustomerState());
    try {
      repository.addCustomer(event.customer);
      final customers = await repository.getAllCustomers();
      emit(customers);
    } catch (e) {
      emit(ErrorCustomerState(e.toString()));
    }
  }

  void _updateCustomerEvent(
      UpdateCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(const LoadingCustomerState());
    try {
      repository.editCustomer(event.id, event.updatedCustomer);
      final customers = await repository.getAllCustomers();
      emit(customers);
    } catch (e) {
      emit(ErrorCustomerState(e.toString()));
    }
  }

  void _removeCustomerEvent(
      RemoveCustomerEvent event, Emitter<CustomerState> emit) async {
    emit(const LoadingCustomerState());
    try {
      repository.removeCustomer(event.id);
      final customers = await repository.getAllCustomers();
      emit(customers);
    } catch (e) {
      emit(ErrorCustomerState(e.toString()));
    }
  }

  void _getAllCustomersEvent(
      GetAllCustomersEvent event, Emitter<CustomerState> emit) async {
    emit(const LoadingCustomerState());
    final newState = await repository.getAllCustomers();
    emit(newState);
  }
}
