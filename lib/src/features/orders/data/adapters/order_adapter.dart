import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/features/orders/interactor/entities/order_entity.dart';

class OrderAdapter {
  static Map<String, dynamic> toMap(OrderEntity order) {
    return {
      'customerId': order.customerId,
      'productId': order.productId,
      'quantity': order.quantity,
      'date': order.date,
    };
  }

  static OrderEntity fromMap(Map<String, dynamic>? map, {String? id}) {
    if (map == null) {
      return OrderEntity(
        customerId: "",
        productId: "",
        quantity: 0,
        date: 0,
      );
    }
    return OrderEntity(
      id: id,
      customerId: map['customerId'] as String? ?? '',
      productId: map['productId'] as String? ?? '',
      quantity: map['quantity'] as int? ?? 0,
      date: map['date'] as int? ?? 0,
    );
  }

  static OrderEntity fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return fromMap(data, id: doc.id);
  }
}
