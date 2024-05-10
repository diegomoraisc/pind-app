/*import 'package:flutter/cupertino.dart';
import 'package:pind_app/src/features/splash/splash_state.dart';
import 'package:pind_app/services/secure_storage.dart';

class SplashController extends ChangeNotifier {
  final SecureStorage _secureStorage;

  SplashController(
    this._secureStorage,
  );

  SplashState _state = SplashInitialState();

  SplashState get state => _state;

  void _changeState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  void isUserLogged() async {
    await Future.delayed(const Duration(seconds: 3));
    

    if (result != null) {
      _changeState(SplashSucessState());
    } else {
      _changeState(SplashErrorState());
    }
  }
}*/
