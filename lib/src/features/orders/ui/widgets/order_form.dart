import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pind_app/src/common/utils/validator.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  double? quantity;
  String? selectedProductId;
  String? selectedCustomerId;
  double? availableQuantity;

  @override
  void initState() {
    quantity = double.tryParse(widget.quantityFieldController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Dialog.fullscreen(
        backgroundColor: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  widget.title.toUpperCase(),
                  style: theme.textTheme.titleSmall,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Produto",
                              style: theme.textTheme.titleSmall!.apply(
                                color: Colors.black,
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
                                    snapshot.data!.docs
                                        .map((doc) {
                                          final product = doc.data()
                                              as Map<String, dynamic>;
                                          double quantity = double.tryParse(
                                                  product['quantity']) ??
                                              0.0;

                                          if (quantity > 0) {
                                            return DropdownMenuItem<String>(
                                              value: doc.id,
                                              onTap: () => setState(
                                                () {
                                                  availableQuantity = quantity;
                                                },
                                              ),
                                              child: Text(product['name']),
                                            );
                                          } else {
                                            return null;
                                          }
                                        })
                                        .whereType<DropdownMenuItem<String>>()
                                        .toList();

                                return Container(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 20,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2<String>(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        hintText: 'Selecione um produto',
                                        hintStyle: theme.textTheme.titleSmall,
                                      ),
                                      value: selectedProductId,
                                      items: productItems,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedProductId = value;
                                          if (value != null) {
                                            widget.onProductSelected(value);
                                          }
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Selecione um produto';
                                        }
                                        return null;
                                      },
                                      style: theme.textTheme.titleSmall,
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.only(
                                          left: 5,
                                        ),
                                      ),
                                      dropdownStyleData:
                                          const DropdownStyleData(
                                        maxHeight: 150,
                                        elevation: 2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cliente",
                              style: theme.textTheme.titleSmall!.apply(
                                color: Colors.black,
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

                                return Container(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 20,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2<String>(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        hintText: 'Selecione um cliente',
                                        hintStyle: theme.textTheme.titleSmall,
                                      ),
                                      value: selectedCustomerId,
                                      items: customerItems,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            selectedCustomerId = value;
                                            if (value != null) {
                                              widget.onCustomerSelected(value);
                                            }
                                          },
                                        );
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Selecione um cliente';
                                        }
                                        return null;
                                      },
                                      style: theme.textTheme.titleSmall,
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.only(
                                          left: 5,
                                        ),
                                      ),
                                      dropdownStyleData:
                                          const DropdownStyleData(
                                        maxHeight: 150,
                                        elevation: 2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        CustomTextFormField(
                          controller: widget.quantityFieldController,
                          fieldName: widget.quantity,
                          hintText: widget.quantityHintText,
                          borderColor: theme.colorScheme.surface,
                          keyboardType: TextInputType.number,
                          validator: (value) => Validator.validateQuantity(
                              value, availableQuantity.toString()),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5),
                          ],
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
                          child: Text(
                            widget.secondaryButtonText,
                            style: theme.textTheme.titleSmall!.apply(
                              color: Colors.black54,
                            ),
                          ),
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
                              if (_formKey.currentState!.validate()) {
                                widget.onPrimaryButtonTapped?.call();
                              }
                            },
                            child: Text(
                              widget.primaryButtonText,
                              style: theme.textTheme.titleSmall!.apply(
                                color: Colors.white,
                              ),
                            ),
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
      ),
    );
  }
}
