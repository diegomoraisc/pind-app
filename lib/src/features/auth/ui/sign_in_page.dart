import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/features/auth/interactor/events/auth_event.dart';
import 'package:pind_app/src/features/auth/interactor/states/auth_state.dart';
import 'package:pind_app/src/common/widgets/custom_divider.dart';
import 'package:pind_app/src/common/widgets/custom_inline_text_button.dart';
import 'package:pind_app/src/common/widgets/custom_modal_bottom_sheet.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
import 'package:pind_app/src/common/widgets/custom_text_button.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';
import 'package:pind_app/src/common/widgets/primary_button.dart';
import 'package:pind_app/src/common/utils/validator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final StreamSubscription _subscription;
  final _bloc = getIt.get<AuthBloc>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isHidden = true;

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

        if (state is LoggedAuthState) {
          context.go('/home');
        } else if (state is ErrorAuthState) {
          final ErrorAuthState error = state;
          customModalBottomSheet(
            context: context,
            text: error.errorMessage,
            bottomText: "Tente novamente",
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  Text(
                    "Entre agora e mantenha seu negócio em movimento",
                    style: theme.textTheme.titleSmall,
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
                    final event = LoginAuthEvent(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    _bloc.add(event);
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
