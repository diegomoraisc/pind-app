import 'package:flutter/material.dart';
import 'package:pind_app/widgets/primary_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/onboarding-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 25.0,
              ),
              child: Image.asset(
                "assets/images/white-logo.png",
                height: 100,
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 88),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gestão inteligente",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "do seu",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Estoque",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 35),
                          child: PrimaryButton(
                            text: "Junte-se a nós",
                            fontSize: 14,
                            textColor: Theme.of(context).colorScheme.primary,
                            backgroundColor: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                        PrimaryButton(
                          text: "Entrar",
                          fontSize: 14,
                          textColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
