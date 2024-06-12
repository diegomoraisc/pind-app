import 'package:pind_app/src/features/customers/interactor/entities/customer_entity.dart';

sealed class CustomerEvent {
  const CustomerEvent();
}

class AddCustomerEvent implements CustomerEvent {
  final CustomerEntity customer;

  AddCustomerEvent({
    required this.customer,
  });
}

class UpdateCustomerEvent implements CustomerEvent {
  final String id;
  final CustomerEntity updatedCustomer;

  UpdateCustomerEvent({
    required this.id,
    required this.updatedCustomer,
  });
}

class RemoveCustomerEvent implements CustomerEvent {
  final String id;

  RemoveCustomerEvent({
    required this.id,
  });
}

class GetAllCustomersEvent implements CustomerEvent {}
