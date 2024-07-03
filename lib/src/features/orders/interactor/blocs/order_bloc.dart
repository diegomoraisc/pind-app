import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pind_app/src/features/orders/interactor/events/order_event.dart';
import 'package:pind_app/src/features/orders/interactor/repositories/order_repository.dart';
import 'package:pind_app/src/features/orders/interactor/states/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;
  OrderBloc(this.repository) : super(const LoadingOrderState()) {
    on<AddOrderEvent>(_addOrderEvent);
    on<RemoveOrderEvent>(_removeOrderEvent);
    on<GetAllOrdersEvent>(_getAllOrdersEvent);
  }

  void _addOrderEvent(AddOrderEvent event, Emitter<OrderState> emit) async {
    emit(const LoadingOrderState());
    try {
      repository.addOrder(event.order);
      final orders = await repository.getAllOrders();
      emit(orders);
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  void _removeOrderEvent(
      RemoveOrderEvent event, Emitter<OrderState> emit) async {
    emit(const LoadingOrderState());
    try {
      repository.removeOrder(event.id);
      final orders = await repository.getAllOrders();
      emit(orders);
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  void _getAllOrdersEvent(
      GetAllOrdersEvent event, Emitter<OrderState> emit) async {
    emit(const LoadingOrderState());
    final newState = await repository.getAllOrders();
    emit(newState);
  }
}
