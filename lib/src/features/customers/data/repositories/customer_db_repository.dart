import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/common/database/firestore_db.dart';
import 'package:pind_app/src/features/customers/data/adapters/customer_adapter.dart';
import 'package:pind_app/src/features/customers/interactor/entities/customer_entity.dart';
import 'package:pind_app/src/features/customers/interactor/exceptions/customer_exception.dart';
import 'package:pind_app/src/features/customers/interactor/repositories/client_repository.dart';
import 'package:pind_app/src/features/customers/interactor/states/customer_state.dart';

class CustomerDbRepository implements CustomerRepository {
  final customersCollection = FirestoreDb.get().collection("customers");

  @override
  Future<CustomerState> addCustomer(CustomerEntity newCustomer) async {
    try {
      final customer = CustomerAdapter.toMap(newCustomer);
      final docRef = await customersCollection.add(customer);

      final addedCustomer = newCustomer.copyWith(id: docRef.id);

      return LoadedCustomerState([addedCustomer]);
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<CustomerState> editCustomer(
      String id, CustomerEntity updatedCustomer) async {
    try {
      final customer = CustomerAdapter.toMap(updatedCustomer);
      await customersCollection.doc(id).update(customer);
      return UpdatedCustomerState(id, updatedCustomer);
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<CustomerState> getAllCustomers() async {
    try {
      QuerySnapshot querySnapshot = await customersCollection.get();

      if (querySnapshot.docs.isEmpty) {
        return ErrorCustomerState(const EmptyListException().message);
      }

      List<CustomerEntity> customers = [];
      for (var doc in querySnapshot.docs) {
        final customer =
            CustomerAdapter.fromMap(doc.data() as Map<String, dynamic>);

        customers.add(customer.copyWith(id: doc.id));
      }
      return LoadedCustomerState(customers);
    } catch (e) {
      return ErrorCustomerState(const UnknownException().message);
    }
  }

  @override
  Future<CustomerState> removeCustomer(String id) async {
    try {
      await customersCollection.doc(id).delete();
      return RemovedCustomerState(id);
    } catch (e) {
      throw const UnknownException();
    }
  }
}
