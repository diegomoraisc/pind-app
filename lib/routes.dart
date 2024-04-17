import 'package:go_router/go_router.dart';
import 'package:pind_app/features/home/home_page.dart';
import 'package:pind_app/features/onboarding/onboarding_page.dart';
import 'package:pind_app/features/sign_in/sign_in_page.dart';
import 'package:pind_app/features/sign_up/sign_up_page.dart';
import 'package:pind_app/features/splash/splash_page.dart';

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
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);

get routeConfig => _router;
