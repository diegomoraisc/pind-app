import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/features/customers/interactor/entities/client_entity.dart';
import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';

class ClientAdapter {
  static Map<String, dynamic> toMap(ClientEntity product) {
    return {
      'name': product.name,
      'cnpj': product.cnpj,
      'adress': product.adress,
      'email': product.email,
      'phoneNumber': product.phoneNumber,
    };
  }

  static ClientEntity fromMap(Map<String, dynamic>? map, {String? id}) {
    if (map == null) {
      return const ClientEntity(
        name: "",
        cnpj: "",
        adress: "",
        email: "",
        phoneNumber: "",
      );
    }
    return ClientEntity(
      id: id,
      name: map['name'] as String? ?? '',
      cnpj: map['cnpj'] as String? ?? '',
      adress: map['adress'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
    );
  }

  static ClientEntity fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return fromMap(data, id: doc.id);
  }
}
