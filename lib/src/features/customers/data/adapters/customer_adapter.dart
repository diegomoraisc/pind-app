import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/features/customers/interactor/entities/customer_entity.dart';

class CustomerAdapter {
  static Map<String, dynamic> toMap(CustomerEntity customer) {
    return {
      'name': customer.name,
      'cnpj': customer.cnpj,
      'adress': customer.adress,
      'email': customer.email,
      'phoneNumber': customer.phoneNumber,
    };
  }

  static CustomerEntity fromMap(Map<String, dynamic>? map, {String? id}) {
    if (map == null) {
      return const CustomerEntity(
        name: "",
        cnpj: "",
        adress: "",
        email: "",
        phoneNumber: "",
      );
    }
    return CustomerEntity(
      id: id,
      name: map['name'] as String? ?? '',
      cnpj: map['cnpj'] as String? ?? '',
      adress: map['adress'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      
    );
  }

  static CustomerEntity fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return fromMap(data, id: doc.id);
  }
}
