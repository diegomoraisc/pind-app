import 'package:pind_app/src/features/orders/interactor/entities/order_entity.dart';

sealed class OrderState {
  const OrderState();
}

class LoadingOrderState implements OrderState {
  const LoadingOrderState();
}

class LoadedOrderState implements OrderState {
  final List<OrderEntity> orders;

  const LoadedOrderState(this.orders);
}

class AddedOrderState implements OrderState {
  final OrderEntity order;

  const AddedOrderState(this.order);
}

class RemovedOrderState implements OrderState {
  final String id;

  const RemovedOrderState(this.id);
}

class ErrorOrderState implements OrderState {
  final String message;

  const ErrorOrderState(this.message);
}
