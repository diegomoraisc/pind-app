import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/features/stock/data/adapters/product_adapter.dart';
import 'package:pind_app/src/common/database/firestore_db.dart';
import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';
import 'package:pind_app/src/features/stock/interactor/exceptions/product_exception.dart';
import 'package:pind_app/src/features/stock/interactor/repositories/product_repository.dart';
import 'package:pind_app/src/features/stock/interactor/states/product_state.dart';

class ProductDbRepository implements ProductRepository {
  final productsCollection = FirestoreDb.get().collection("products");

  @override
  Future<ProductState> addProduct(ProductEntity newProduct) async {
    try {
      final product = ProductAdapter.toMap(newProduct);
      final docRef = await productsCollection.add(product);

      final addedProduct = newProduct.copyWith(id: docRef.id);

      return LoadedProductState([addedProduct]);
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<ProductState> editProduct(
      String id, ProductEntity updatedProduct) async {
    try {
      final product = ProductAdapter.toMap(updatedProduct);
      await productsCollection.doc(id).update(product);
      return UpdatedProductState(id, updatedProduct);
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<ProductState> getAllProducts() async {
    try {
      QuerySnapshot querySnapshot = await productsCollection.get();

      if (querySnapshot.docs.isEmpty) {
        return ErrorProductState(const EmptyListException().message);
      }

      List<ProductEntity> products = [];
      for (var doc in querySnapshot.docs) {
        final product =
            ProductAdapter.fromMap(doc.data() as Map<String, dynamic>);

        products.add(product.copyWith(id: doc.id));
      }
      return LoadedProductState(products);
    } catch (e) {
      return ErrorProductState(const UnknownException().message);
    }
  }

  @override
  Future<ProductState> removeProduct(String id) async {
    try {
      await productsCollection.doc(id).delete();
      return RemovedProductState(id);
    } catch (e) {
      throw const UnknownException();
    }
  }
}
