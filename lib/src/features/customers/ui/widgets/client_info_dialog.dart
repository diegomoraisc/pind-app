import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/widgets/box_text.dart';

class ClientInfoDialog extends StatelessWidget {
  final String title;
  final String clientName;
  final String cnpj;
  final String clientAdress;
  final String clientEmail;
  final String clientPhoneNumber;

  const ClientInfoDialog({
    Key? key,
    required this.title,
    required this.clientName,
    required this.cnpj,
    required this.clientAdress,
    required this.clientEmail,
    required this.clientPhoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      surfaceTintColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                title.toUpperCase(),
                style: AppTextStyles.medium14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  BoxText(
                    text: clientName,
                  ),
                  BoxText(
                    text: cnpj,
                  ),
                  BoxText(
                    text: clientAdress,
                  ),
                  BoxText(
                    text: clientEmail,
                  ),
                  BoxText(
                    text: clientPhoneNumber,
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
