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

class GetCustomerNameEvent implements OrderEvent {
  final String customerId;

  const GetCustomerNameEvent({
    required this.customerId,
  });
}

class GetProductNameEvent implements OrderEvent {
  final String productId;

  const GetProductNameEvent({
    required this.productId,
  });
}
