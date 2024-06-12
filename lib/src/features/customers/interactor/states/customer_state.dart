import 'package:pind_app/src/features/customers/interactor/entities/customer_entity.dart';

sealed class CustomerState {
  const CustomerState();
}

class LoadingCustomerState implements CustomerState {
  const LoadingCustomerState();
}

class AddedCustomerState implements CustomerState {
  final CustomerEntity customer;

  const AddedCustomerState(this.customer);
}

class UpdatedCustomerState implements CustomerState {
  final String id;
  final CustomerEntity updatedCustomer;

  UpdatedCustomerState(this.id, this.updatedCustomer);
}

class RemovedCustomerState implements CustomerState {
  final String id;

  RemovedCustomerState(this.id);
}

class LoadedCustomerState implements CustomerState {
  List<CustomerEntity> customers;

  LoadedCustomerState(this.customers);
}

class ErrorCustomerState implements CustomerState {
  final String message;

  ErrorCustomerState(this.message);
}
