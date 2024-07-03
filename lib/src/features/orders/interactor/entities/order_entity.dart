class OrderEntity {
  final String? id;
  final String customerId;
  final String productId;
  final int quantity;
  final int date;

  OrderEntity({
    this.id,
    required this.customerId,
    required this.productId,
    required this.quantity,
    required this.date,
  });

  OrderEntity copyWith({
    String? id,
    String? customerId,
    String? productId,
    int? quantity,
    int? date,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
    );
  }
}
