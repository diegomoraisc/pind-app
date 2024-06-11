import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';

sealed class ProductEvent {
  const ProductEvent();
}

class AddProductEvent implements ProductEvent {
  final ProductEntity product;

  AddProductEvent({
    required this.product,
  });
}

class UpdateProductEvent implements ProductEvent {
  final String id;
  final ProductEntity updatedProduct;

  UpdateProductEvent({
    required this.id,
    required this.updatedProduct,
  });
}

class RemoveProductEvent implements ProductEvent {
  final String id;

  RemoveProductEvent({
    required this.id,
  });
}

class GetAllProductsEvent implements ProductEvent {}
