import 'package:flutter/material.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
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
                    text: customerName,
                  ),
                  BoxText(
                    text: cnpj,
                  ),
                  BoxText(
                    text: customerAdress,
                  ),
                  BoxText(
                    text: customerEmail,
                  ),
                  BoxText(
                    text: customerPhoneNumber,
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
