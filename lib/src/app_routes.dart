import 'package:go_router/go_router.dart';
import 'package:pind_app/src/features/home/ui/home_page.dart';
import 'package:pind_app/src/features/onboarding/ui/onboarding_page.dart';
import 'package:pind_app/src/features/auth/ui/sign_in_page.dart';
import 'package:pind_app/src/features/auth/ui/sign_up_page.dart';
import 'package:pind_app/src/features/auth/ui/splash_page.dart';

final _router = GoRouter(
  initialLocation: '/',
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
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);

get routeConfig => _router;
