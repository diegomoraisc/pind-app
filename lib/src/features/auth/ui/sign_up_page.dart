import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:pind_app/src/features/auth/interactor/events/auth_event.dart';
import 'package:pind_app/src/features/auth/interactor/states/auth_state.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/common/widgets/custom_divider.dart';
import 'package:pind_app/src/common/widgets/custom_inline_text_button.dart';
import 'package:pind_app/src/common/widgets/custom_modal_bottom_sheet.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';
import 'package:pind_app/src/common/widgets/primary_button.dart';
import 'package:pind_app/src/common/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final StreamSubscription _subscription;
  final _bloc = getIt.get<AuthBloc>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _subscription = _bloc.stream.listen(
      (state) {
        if (state is LoadingAuthState) {
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

        if (state is RegisteredAuthState) {
          context.go('/home');
        } else if (state is ErrorAuthState) {
          final ErrorAuthState error = state;
          customModalBottomSheet(
            context: context,
            text: error.errorMessage,
            bottomText: 'Tente novamente',
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
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
            const Padding(
              padding: EdgeInsets.only(
                top: 72,
                left: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Junte-se a nós. Crie sua conta agora.",
                      style: AppTextStyles.semiBold32,
                    ),
                  ),
                  Text(
                    "Vamos começar a gerenciar seu estoque! Registre-se agora",
                    style: AppTextStyles.medium14,
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
                    final event = RegisterAuthEvent(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    _bloc.add(event);
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
