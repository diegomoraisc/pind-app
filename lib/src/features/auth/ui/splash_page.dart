import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
import 'package:pind_app/src/features/auth/interactor/events/auth_event.dart';
import '../../../common/utils/locator.dart';
import '../interactor/blocs/auth_bloc.dart';
import '../interactor/states/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final bloc = getIt<AuthBloc>();
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    bloc.add(CheckAuthEvent());

    _subscription = bloc.stream.listen(
      (state) {
        if (state is LoggedAuthState) {
          context.go('/home');
        } else if (state is LoggedOutAuthState) {
          context.go('/');
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
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
