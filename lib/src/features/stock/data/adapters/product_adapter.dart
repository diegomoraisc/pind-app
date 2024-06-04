import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';

class ProductAdapter {
  static Map<String, dynamic> toMap(ProductEntity product) {
    return {
      'name': product.name,
      'quantity': product.quantity,
    };
  }

  static ProductEntity fromMap(Map<String, dynamic>? map, {String? id}) {
    if (map == null) return ProductEntity(name: "", quantity: "0.0");
    return ProductEntity(
      id: id,
      name: map['name'] as String? ?? '',
      quantity: map['quantity'] as String? ?? '0.0',
    );
  }

  static ProductEntity fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return fromMap(data, id: doc.id);
  }
}
