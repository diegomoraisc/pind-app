import 'package:pind_app/src/features/orders/interactor/entities/order_entity.dart';

sealed class OrderEvent {
  const OrderEvent();
}

class AddOrderEvent implements OrderEvent {
  final OrderEntity order;

  const AddOrderEvent({
    required this.order,
  });
}

class RemoveOrderEvent implements OrderEvent {
  final String id;

  const RemoveOrderEvent({
    required this.id,
  });
}

class GetAllOrdersEvent implements OrderEvent {}
