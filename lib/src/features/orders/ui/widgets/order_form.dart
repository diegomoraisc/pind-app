import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pind_app/src/common/constants/app_colors.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/widgets/custom_text_form_field.dart';

class OrderForm extends StatefulWidget {
  final String title;
  final String primaryButtonText;
  final String secondaryButtonText;
  final String quantity;
  final String quantityHintText;
  final TextEditingController quantityFieldController;
  final VoidCallback? onPrimaryButtonTapped;
  final VoidCallback? onSecondaryButtonTapped;
  final ValueChanged<String> onProductSelected;
  final ValueChanged<String> onCustomerSelected;

  const OrderForm({
    super.key,
    required this.title,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.quantity,
    required this.quantityHintText,
    required this.quantityFieldController,
    this.onPrimaryButtonTapped,
    this.onSecondaryButtonTapped,
    required this.onProductSelected,
    required this.onCustomerSelected,
  });

  @override
  OrderFormState createState() => OrderFormState();
}

class OrderFormState extends State<OrderForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedProductId;
  String? selectedCustomerId;
  double? availableQuantity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Dialog.fullscreen(
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                widget.title.toUpperCase(),
                style: AppTextStyles.medium14,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Produto",
                                style: AppTextStyles.medium14.apply(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('products')
                                  .get(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }

                                List<DropdownMenuItem<String>> productItems =
                                    snapshot.data!.docs.map((doc) {
                                  final product =
                                      doc.data() as Map<String, dynamic>;
                                  double quantity =
                                      double.tryParse(product['quantity']) ??
                                          0.0;
                                  return DropdownMenuItem<String>(
                                    value: doc.id,
                                    enabled: quantity > 0,
                                    onTap: () => setState(() {
                                      availableQuantity = quantity;
                                    }),
                                    child: Text(product['name']),
                                  );
                                }).toList();

                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    value: selectedProductId,
                                    hint: const Text(
                                      'Selecione um produto',
                                      style: AppTextStyles.medium14,
                                    ),
                                    items: productItems,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedProductId = value;
                                        if (value != null) {
                                          widget.onProductSelected(value);
                                        }
                                      });
                                    },
                                    style: AppTextStyles.medium14,
                                    buttonStyleData: ButtonStyleData(
                                      height: 60,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 150,
                                      elevation: 2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Cliente",
                                style: AppTextStyles.medium14.apply(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('customers')
                                  .get(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }

                                List<DropdownMenuItem<String>> customerItems =
                                    snapshot.data!.docs.map((doc) {
                                  final customer =
                                      doc.data() as Map<String, dynamic>;
                                  return DropdownMenuItem<String>(
                                    value: doc.id,
                                    child: Text(customer['name']),
                                  );
                                }).toList();

                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    value: selectedCustomerId,
                                    hint: const Text(
                                      'Selecione um cliente',
                                      style: AppTextStyles.medium14,
                                    ),
                                    items: customerItems,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCustomerId = value;
                                        if (value != null) {
                                          widget.onCustomerSelected(value);
                                        }
                                      });
                                    },
                                    style: AppTextStyles.medium14,
                                    buttonStyleData: ButtonStyleData(
                                      height: 60,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 150,
                                      elevation: 2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      CustomTextFormField(
                        controller: widget.quantityFieldController,
                        fieldName: widget.quantity,
                        hintText: widget.quantityHintText,
                        borderColor: AppColors.grey,
                        keyboardType: TextInputType.number,
                        helperStyle: TextStyle(
                          color: theme.colorScheme.primary,
                        ),
                        helperText: availableQuantity != null
                            ? "Quantidade disponível: $availableQuantity"
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFC4C4C4)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: widget.onSecondaryButtonTapped,
                        child: Text(widget.secondaryButtonText,
                            style: AppTextStyles.medium14
                                .apply(color: Colors.black54)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.tertiary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            if (selectedCustomerId == null ||
                                selectedProductId == null ||
                                double.parse(
                                        widget.quantityFieldController.text) >
                                    availableQuantity!) {
                              return _showErrorSnackBar(
                                "Ocorreu um erro. Por favor, verifique os dados inseridos e tente novamente.",
                              );
                            }
                            widget.onPrimaryButtonTapped?.call();
                          },
                          child: Text(widget.primaryButtonText,
                              style: AppTextStyles.medium14
                                  .apply(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
