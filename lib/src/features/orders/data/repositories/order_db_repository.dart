import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/common/database/firestore_db.dart';
import 'package:pind_app/src/features/orders/data/adapters/order_adapter.dart';
import 'package:pind_app/src/features/orders/interactor/entities/order_entity.dart';
import 'package:pind_app/src/features/orders/interactor/exceptions/order_exception.dart';
import 'package:pind_app/src/features/orders/interactor/repositories/order_repository.dart';
import 'package:pind_app/src/features/orders/interactor/states/order_state.dart';
import 'package:pind_app/src/features/stock/data/adapters/product_adapter.dart';
import 'package:pind_app/src/features/stock/interactor/entities/product_entity.dart';

class OrderDbRepository implements OrderRepository {
  final ordersCollection = FirestoreDb.get().collection("orders");

  @override
  Future<OrderState> addOrder(OrderEntity newOrder) async {
    try {
      final order = OrderAdapter.toMap(newOrder);
      final docRef = await ordersCollection.add(order);
      final productSnapshot = await FirestoreDb.get()
          .collection('products')
          .doc(newOrder.productId)
          .get();
      if (productSnapshot.exists) {
        ProductEntity product = ProductAdapter.fromDocument(productSnapshot);
        double newQuantity = double.parse(product.quantity) - newOrder.quantity;

        if (newQuantity < 0) {
          return const ErrorOrderState('Quantidade insuficiente no estoque');
        }

        await FirestoreDb.get()
            .collection('products')
            .doc(newOrder.productId)
            .update({'quantity': newQuantity.toString()});
      }
      final addedOrder = newOrder.copyWith(id: docRef.id);
      return LoadedOrderState([addedOrder]);
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<OrderState> getAllOrders() async {
    try {
      QuerySnapshot querySnapshot = await ordersCollection.get();

      if (querySnapshot.docs.isEmpty) {
        return ErrorOrderState(const EmptyListException().message);
      }

      List<OrderEntity> orders = [];
      for (var doc in querySnapshot.docs) {
        final order = OrderAdapter.fromMap(doc.data() as Map<String, dynamic>);

        orders.add(order.copyWith(id: doc.id));
      }
      return LoadedOrderState(orders);
    } catch (e) {
      return ErrorOrderState(const UnknownException().message);
    }
  }

  @override
  Future<OrderState> removeOrder(String id) {
    throw UnimplementedError();
  }
}
