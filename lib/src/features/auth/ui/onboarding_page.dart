import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/features/auth/ui/widgets/orboarding_card.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/onboarding-background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 25.0,
              ),
              child: Image.asset(
                "assets/images/white-logo.png",
                height: 100,
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 32,
                bottom: 40,
                left: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OnboardingCard(
                    title: "Controle do seu estoque na palma da sua mão",
                    description: "Comece agora mesmo!",
                    onPressed: () => context.push('/sign-in'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
