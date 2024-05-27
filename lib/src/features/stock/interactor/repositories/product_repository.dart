import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';
import 'package:pind_app/src/features/stock/interactor/states/product_state.dart';

abstract class ProductRepository {
  Future<ProductState> addProduct(ProductEntity newProduct);

  Future<ProductState> editProduct(
      String id, ProductEntity updatedProduct);

  Future<ProductState> removeProduct(String id);

  Future<ProductState> getAllProducts();
}
