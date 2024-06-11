import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pind_app/src/features/stock/interactor/events/product_event.dart';
import 'package:pind_app/src/features/stock/interactor/repositories/product_repository.dart';
import 'package:pind_app/src/features/stock/interactor/states/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(const LoadingProductState()) {
    on<AddProductEvent>(_addProductEvent);
    on<UpdateProductEvent>(_updateProductEvent);
    on<RemoveProductEvent>(_removeProductEvent);
    on<GetAllProductsEvent>(_getAllProductsEvent);
  }

  void _addProductEvent(
      AddProductEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingProductState());
    try {
      await repository.addProduct(event.product);
      final products = await repository.getAllProducts();
      emit(products);
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

  void _updateProductEvent(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingProductState());
    try {
      await repository.editProduct(event.id, event.updatedProduct);
      final products = await repository.getAllProducts();
      emit(products);
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

  void _removeProductEvent(
      RemoveProductEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingProductState());
    try {
      await repository.removeProduct(event.id);
      final products = await repository.getAllProducts();
      emit(products);
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

  void _getAllProductsEvent(
      GetAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingProductState());
    final newState = await repository.getAllProducts();
    emit(newState);
  }
}
