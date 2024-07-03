import 'package:pind_app/src/features/orders/interactor/entities/order_entity.dart';
import 'package:pind_app/src/features/orders/interactor/states/order_state.dart';

abstract class OrderRepository {
  Future<OrderState> addOrder(OrderEntity newOrder);

  Future<OrderState> removeOrder(String id);

  Future<OrderState> getAllOrders();
}
