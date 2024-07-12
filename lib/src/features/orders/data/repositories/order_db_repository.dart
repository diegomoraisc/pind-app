import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/common/database/firestore_db.dart';
import 'package:pind_app/src/features/customers/data/adapters/customer_adapter.dart';
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
  Future<OrderState> removeOrder(String id) async {
    try {
      await ordersCollection.doc(id).delete();
      return RemovedOrderState(id);
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<OrderState> getCustomerName(String id) async {
    final customerSnapshot =
        await FirestoreDb.get().collection('customers').doc(id).get();

    if (customerSnapshot.exists) {
      final customerName = CustomerAdapter.fromDocument(customerSnapshot).name;
      return CustomerNameLoadedState(customerName);
    }

    return ErrorOrderState(const UnknownCustomerException().message);
  }

  @override
  Future<OrderState> getProductName(String id) async {
    final productSnapshot =
        await FirestoreDb.get().collection('products').doc(id).get();

    if (productSnapshot.exists) {
      final productName = ProductAdapter.fromDocument(productSnapshot).name;
      return ProductNameLoadedState(productName);
    }

    return ErrorOrderState(const UnknownProductException().message);
  }
}
