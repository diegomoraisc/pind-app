import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';

class ProductAdapter {
  static Map<String, dynamic> toMap(ProductEntity product) {
    return {
      'id': product.id ?? '',
      'name': product.name ?? '',
      'quantity': product.quantity ?? '0.0',
      'category': product.category ?? '',
    };
  }

  static ProductEntity fromMap(Map<String, dynamic>? map) {
    if (map == null) return ProductEntity(category: null);
    return ProductEntity(
      name: map['name'] as String? ?? '',
      quantity: map['quantity'] as String? ?? '0.0',
      category: map['category'] as String? ?? '',
    );
  }
}
