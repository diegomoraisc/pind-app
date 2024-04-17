import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/features/splash/splash_controller.dart';
import 'package:pind_app/features/splash/splash_state.dart';
import 'package:pind_app/locator.dart';
import 'package:pind_app/widgets/custom_progress_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = getIt.get<SplashController>();

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    _controller.isUserLogged();
    _controller.addListener(
      () {
        if (_controller.state is SplashSucessState) {
          context.go('/home');
        } else {
          context.go('/');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 15,
              child: Image.asset("assets/images/white-logo.png"),
            ),
            const Spacer(flex: 1),
            const Flexible(
              flex: 15,
              child: SizedBox(
                width: 50,
                height: 50,
                child: CustomProgressIndicator(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
