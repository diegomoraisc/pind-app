import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/features/sign_up/sign_up_controller.dart';
import 'package:pind_app/features/sign_up/sign_up_state.dart';
import 'package:pind_app/locator.dart';
import 'package:pind_app/widgets/custom_divider.dart';
import 'package:pind_app/widgets/custom_inline_text_button.dart';
import 'package:pind_app/widgets/custom_modal_bottom_sheet.dart';
import 'package:pind_app/widgets/custom_progress_indicator.dart';
import 'package:pind_app/widgets/custom_text_form_field.dart';
import 'package:pind_app/widgets/primary_button.dart';
import 'package:pind_app/widgets/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = getIt.get<SignUpController>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignUpLoadingState) {
        showDialog(
          context: context,
          builder: (ctx) => Center(
            child: CustomProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      } else {
        context.pop();
      }
      if (_controller.state is SignUpSucessState) {
        context.go('/home');
      }
      if (_controller.state is SignUpErrorState) {
        final error = _controller.state as SignUpErrorState;
        customModalBottomSheet(
          context: context,
          text: error.message,
          bottomText: 'Tente novamente',
        );
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                top: 72,
                left: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Junte-se a nós. Crie sua conta agora.",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Text(
                    "Vamos começar a gerenciar seu estoque! Registre-se agora",
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
                      fieldName: "Nome Completo",
                      hintText: "Digite seu nome completo",
                      controller: _nameController,
                      validator: Validator.validateName,
                      keyboardType: TextInputType.name,
                    ),
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
                      helperText:
                          "Por favor, escolha uma senha com pelo menos 8 caracteres, incluindo pelo menos uma letra maiúscula e um número",
                      obscureText: isPasswordHidden,
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        }),
                        child: isPasswordHidden
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                    CustomTextFormField(
                      fieldName: "Confirmar Senha",
                      hintText: "Confirme sua senha",
                      validator: (value) => Validator.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                      obscureText: isConfirmPasswordHidden,
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          isConfirmPasswordHidden = !isConfirmPasswordHidden;
                        }),
                        child: isConfirmPasswordHidden
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
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
                textColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
                text: "Registrar",
                fontSize: 14,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _controller.signUp(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  }
                },
              ),
            ),
            const CustomDivider(text: "OU"),
            Padding(
              padding: const EdgeInsets.only(bottom: 130),
              child: CustomInlineTextButton(
                text: "Já possuí uma conta?",
                textButton: "Entrar agora",
                onPressed: () => context.push('/sign-in'),
                textColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
