
import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';

sealed class ProductState {
  const ProductState();
}

class InitialProductState implements ProductState {
  final List<ProductEntity> products;

  const InitialProductState(this.products);
}

class LoadingProductState implements ProductState {
  const LoadingProductState();
}

class AddedProductState implements ProductState {
  final ProductEntity product;

  const AddedProductState(this.product);
}

class UpdatedProductState implements ProductState {
  final String id;
  final ProductEntity updatedProduct;

  UpdatedProductState(this.id, this.updatedProduct);
}

class RemovedProductState implements ProductState {
  final String id;

  RemovedProductState(this.id);
}

class LoadedProductState implements ProductState {
  final List<ProductEntity> products;

  LoadedProductState(this.products);
}

class ErrorProductState implements ProductState {
  final String message;

  ErrorProductState(this.message);
}
