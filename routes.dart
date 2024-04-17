import 'package:go_router/go_router.dart';
import 'package:pind_app/features/onboarding/onboarding_page.dart';
import 'package:pind_app/features/splash/splash_page.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    )
  ],
);

get routes => _router;
