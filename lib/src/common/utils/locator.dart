import 'package:get_it/get_it.dart';
import 'package:pind_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:pind_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:pind_app/src/features/auth/data/services/firebase_auth_service.dart';
import 'package:pind_app/src/features/customers/data/repositories/customer_db_repository.dart';
import 'package:pind_app/src/features/customers/interactor/blocs/customer_bloc.dart';
import 'package:pind_app/src/features/customers/interactor/repositories/client_repository.dart';
import 'package:pind_app/src/features/orders/data/repositories/order_db_repository.dart';
import 'package:pind_app/src/features/orders/interactor/blocs/order_bloc.dart';
import 'package:pind_app/src/features/orders/interactor/repositories/order_repository.dart';
import 'package:pind_app/src/features/stock/data/repositories/stock_db_repository.dart';
import 'package:pind_app/src/features/stock/interactor/blocs/product_bloc.dart';
import 'package:pind_app/src/features/stock/interactor/repositories/product_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthService>(
    () => FirebaseAuthService(),
  );

  getIt.registerLazySingleton<ProductRepository>(
    () => ProductDbRepository(),
  );

  getIt.registerLazySingleton<CustomerRepository>(
    () => CustomerDbRepository(),
  );

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderDbRepository(),
  );

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      getIt.get<AuthService>(),
    ),
  );

  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      getIt.get<ProductRepository>(),
    ),
  );

  getIt.registerFactory<CustomerBloc>(
    () => CustomerBloc(
      getIt.get<CustomerRepository>(),
    ),
  );

  getIt.registerFactory<OrderBloc>(
    () => OrderBloc(
      getIt.get<OrderRepository>(),
    ),
  );
}
