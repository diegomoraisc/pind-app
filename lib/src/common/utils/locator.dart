import 'package:get_it/get_it.dart';
import 'package:pind_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:pind_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:pind_app/src/features/auth/data/services/firebase_auth_service.dart';
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
}
