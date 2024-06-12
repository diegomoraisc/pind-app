import 'package:pind_app/src/features/customers/interactor/entities/customer_entity.dart';
import 'package:pind_app/src/features/customers/interactor/states/customer_state.dart';

abstract class CustomerRepository {
  Future<CustomerState> addCustomer(CustomerEntity newCustomer);

  Future<CustomerState> editCustomer(String id, CustomerEntity updatedCustomer);

  Future<CustomerState> removeCustomer(String id);

  Future<CustomerState> getAllCustomers();
}
