import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/widgets/custom_divider.dart';
import 'package:pind_app/widgets/custom_inline_text_button.dart';
import 'package:pind_app/widgets/custom_text_button.dart';
import 'package:pind_app/widgets/custom_text_form_field.dart';
import 'package:pind_app/widgets/primary_button.dart';
import 'package:pind_app/widgets/utils/validator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                top: 72,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Text(
                      "Faça o login na sua conta.",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Text(
                    "Entre agora e mantenha seu negócio em movimento",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  right: 24,
                  left: 24,
                ),
                child: Column(
                  children: [
                    CustomTextFormField(
                      fieldName: "E-mail",
                      hintText: "Digite seu e-mail",
                      controller: _emailController,
                      validator: Validator.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextFormField(
                      fieldName: "Senha",
                      hintText: "Digite sua senha",
                      controller: _passwordController,
                      validator: Validator.validatePassword,
                      obscureText: isHidden,
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          isHidden = !isHidden;
                        }),
                        child: isHidden
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                    CustomTextButton(
                      text: "Esqueceu sua senha?",
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 14,
                right: 24,
                left: 24,
              ),
              child: PrimaryButton(
                width: MediaQuery.of(context).size.width,
                height: 60,
                text: "Entrar",
                textColor: Colors.white,
                fontSize: 14,
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    const SnackBar(content: Text("Usuário logado!"));
                  }
                },
              ),
            ),
            const CustomDivider(text: "OU"),
            CustomInlineTextButton(
              text: "Não tem uma conta?",
              textButton: "Cadastre-se",
              onPressed: () => context.push('/sign-up'),
              textColor: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
