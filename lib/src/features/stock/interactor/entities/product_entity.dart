class ProductEntity {
  String? id;
  String? name;
  String? quantity;
  String? category;
  ProductEntity({
    this.id,
    this.name,
    this.quantity, required category,
  });
}
