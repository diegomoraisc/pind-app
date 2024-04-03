import 'package:flutter/material.dart';
import 'package:pind_app/widgets/custom_progress_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

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
