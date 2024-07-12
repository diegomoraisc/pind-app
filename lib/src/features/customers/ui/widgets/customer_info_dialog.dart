import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/common/widgets/box_text.dart';

class CustomerInfo extends StatelessWidget {
  final String title;
  final String customerName;
  final String cnpj;
  final String customerAdress;
  final String customerEmail;
  final String customerPhoneNumber;

  const CustomerInfo({
    Key? key,
    required this.title,
    required this.customerName,
    required this.cnpj,
    required this.customerAdress,
    required this.customerEmail,
    required this.customerPhoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog.fullscreen(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 5),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    iconSize: 18,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    alignment: AlignmentDirectional.centerStart,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                  ),
                  Text(
                    title.toUpperCase(),
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Cliente",
                          style: theme.textTheme.titleSmall!.apply(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      BoxText(
                        text: customerName,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "CNPJ",
                          style: theme.textTheme.titleSmall!.apply(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      BoxText(
                        text: cnpj,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Endereço",
                          style: theme.textTheme.titleSmall!.apply(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      BoxText(
                        text: customerAdress,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "E-mail",
                          style: theme.textTheme.titleSmall!.apply(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      BoxText(
                        text: customerEmail,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Telefone",
                          style: theme.textTheme.titleSmall!.apply(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      BoxText(
                        text: customerPhoneNumber,
                      ),
                    ],
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
