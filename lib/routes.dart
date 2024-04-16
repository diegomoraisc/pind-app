import 'package:go_router/go_router.dart';
import 'package:pind_app/pages/onboarding_page.dart';
import 'package:pind_app/pages/sign_in_page.dart';
import 'package:pind_app/pages/sign_up_page.dart';
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
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignUpPage(),
    ),
  ],
);

get routeConfig => _router;