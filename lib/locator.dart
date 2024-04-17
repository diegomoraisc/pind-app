import 'package:get_it/get_it.dart';
import 'package:pind_app/features/sign_in/sign_in_controller.dart';
import 'package:pind_app/features/sign_up/sign_up_controller.dart';
import 'package:pind_app/features/splash/splash_controller.dart';
import 'package:pind_app/services/auth_service.dart';
import 'package:pind_app/services/firebase_auth_service.dart';
import 'package:pind_app/services/secure_storage.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthService>(() => FirebaseAuthService());

  getIt.registerFactory<SplashController>(
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
  );
}
