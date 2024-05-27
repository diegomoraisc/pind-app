import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';
import 'package:pind_app/src/features/stock/interactor/events/product_event.dart';
import 'package:pind_app/src/features/stock/interactor/repositories/product_repository.dart';
import 'package:pind_app/src/features/stock/interactor/states/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  StreamSubscription<List<ProductEntity>>? _productsSubscription;

  ProductBloc(this.repository) : super(const InitialProductState([])) {
    on<AddProductEvent>(_addProductEvent);
    on<UpdateProductEvent>(_updateProductEvent);
    on<RemoveProductEvent>(_removeProductEvent);
    on<GetAllProductsEvent>(_getAllProductsEvent);
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }

  void _addProductEvent(
      AddProductEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingProductState());
    final newState = await repository.addProduct(event.product);
    emit(newState);
  }

  void _updateProductEvent(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingProductState());
    final newState =
        await repository.editProduct(event.id, event.updatedProduct);
    emit(newState);
  }

  void _removeProductEvent(
      RemoveProductEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingProductState());
    final newState = await repository.removeProduct(event.id);
    emit(newState);
  }

  void _getAllProductsEvent(
      GetAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingProductState());
    final newState = await repository.getAllProducts();
    emit(newState);
  }
}
