import 'package:get_it/get_it.dart';
import 'package:pind_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:pind_app/src/features/profile/profile_controller.dart';
import 'package:pind_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:pind_app/src/features/auth/data/services/firebase_auth_service.dart';
import 'package:pind_app/services/secure_storage.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(getIt.get<AuthService>()),
  );

  /*getIt.registerFactory<SplashController>(
    () => SplashController(
      const SecureStorage(),
    ),
  );

  getIt.registerFactory<SignInController>(
    () => SignInController(
      getIt.get<AuthService>(),
      const SecureStorage(),
    ),
  );

  getIt.registerFactory<SignUpController>(
    () => SignUpController(
      getIt.get<AuthService>(),
      const SecureStorage(),
    ),
  ); */

  getIt.registerFactory<ProfileController>(
    () => ProfileController(
      getIt.get<AuthService>(),
      const SecureStorage(),
    ),
  );
}
