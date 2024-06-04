class ProductEntity {
  final String? id;
  final String name;
  final String quantity;

  ProductEntity({
    this.id,
    required this.name,
    required this.quantity,
  });

  ProductEntity copyWith({
    String? id,
    String? name,
    String? quantity,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}
