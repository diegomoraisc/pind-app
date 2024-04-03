import 'package:go_router/go_router.dart';
import 'package:pind_app/pages/onboarding_page.dart';
import 'package:pind_app/pages/splash_page.dart';

final _router = GoRouter(
  initialLocation: '/splash',
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

get routeConfig => _router;