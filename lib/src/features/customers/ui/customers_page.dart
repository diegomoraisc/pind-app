import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
import 'package:pind_app/src/features/customers/interactor/blocs/customer_bloc.dart';
import 'package:pind_app/src/features/customers/interactor/entities/customer_entity.dart';
import 'package:pind_app/src/features/customers/interactor/events/customer_event.dart';
import 'package:pind_app/src/features/customers/interactor/states/customer_state.dart';
import 'package:pind_app/src/features/customers/ui/widgets/customer_card.dart';
import 'package:pind_app/src/features/customers/ui/widgets/customer_form_dialog.dart';
import 'package:pind_app/src/features/customers/ui/widgets/customer_info_dialog.dart';
import 'package:uuid/uuid.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final _bloc = getIt.get<CustomerBloc>();
  final _nameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _adressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllCustomersEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cnpjController.dispose();
    _adressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _clearTextFields() {
    _nameController.clear();
    _cnpjController.clear();
    _adressController.clear();
    _emailController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocBuilder<CustomerBloc, CustomerState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadingCustomerState) {
            return Center(
              child: CustomProgressIndicator(
                color: theme.colorScheme.tertiary,
              ),
            );
          } else if (state is LoadedCustomerState) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: state.customers.length,
              itemBuilder: (context, index) {
                final customer = state.customers[index];
                return CustomerCard(
                  name: customer.name,
                  adress: customer.adress,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (builder) => CustomerInfo(
                        title: customer.name,
                        customerName: customer.name,
                        cnpj: customer.cnpj,
                        customerAdress: customer.adress,
                        customerEmail: customer.email,
                        customerPhoneNumber: customer.phoneNumber,
                      ),
                    );
                  },
                  onEdit: (context) {
                    _nameController.text = customer.name;
                    _cnpjController.text = customer.cnpj;
                    _adressController.text = customer.adress;
                    _emailController.text = customer.email;
                    _phoneController.text = customer.phoneNumber;
                    customerFormDialog(
                      context: context,
                      customerId: customer.id,
                      title: "Editar informações de um cliente",
                      customerName: "Nome",
                      nameHintText: "Nome do cliente",
                      nameFieldController: _nameController,
                      cnpj: "CNPJ",
                      cnpjHintText: "CNPJ do cliente",
                      cnpjFieldController: _cnpjController,
                      customerAdress: "Endereço",
                      adressHintText: "Endereço do cliente",
                      adressFieldController: _adressController,
                      customerEmail: "Email",
                      emailHintText: "Email do cliente",
                      emailFieldController: _emailController,
                      customerPhoneNumber: "Telefone",
                      phoneNumberHintText: "Telefone para contato",
                      phoneNumberFieldController: _phoneController,
                      primaryButtonText: "Editar",
                      secondaryButtonText: "Cancelar",
                      onPrimaryButtonTapped: (dialogContext) {
                        final name = _nameController.text;
                        final cnpj = _cnpjController.text;
                        final adress = _adressController.text;
                        final email = _emailController.text;
                        final phoneNumber = _phoneController.text;
                        if (customer.id != null) {
                          _bloc.add(
                            UpdateCustomerEvent(
                              id: customer.id!,
                              updatedCustomer: CustomerEntity(
                                id: customer.id,
                                name: name,
                                cnpj: cnpj,
                                adress: adress,
                                email: email,
                                phoneNumber: phoneNumber,
                              ),
                            ),
                          );
                        }
                        dialogContext.pop();
                        _clearTextFields();
                        _bloc.add(GetAllCustomersEvent());
                      },
                      onSecondaryButtonTapped: (dialogContext) {
                        dialogContext.pop();
                        _clearTextFields();
                      },
                    );
                  },
                  onRemove: (context) {
                    _bloc.add(RemoveCustomerEvent(id: customer.id!));
                    _bloc.add(GetAllCustomersEvent());
                  },
                );
              },
            );
          } else if (state is ErrorCustomerState) {
            final message = state.message;
            return Center(
              child: Text(
                message,
                style: theme.textTheme.titleSmall,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          customerFormDialog(
            context: context,
            title: "Adicionar novo cliente",
            customerName: "Nome",
            nameHintText: "Nome do cliente",
            nameFieldController: _nameController,
            cnpj: "CNPJ",
            cnpjHintText: "CNPJ do cliente",
            cnpjFieldController: _cnpjController,
            customerAdress: "Endereço",
            adressHintText: "Endereço do cliente",
            adressFieldController: _adressController,
            customerEmail: "Email",
            emailHintText: "Email do cliente",
            emailFieldController: _emailController,
            customerPhoneNumber: "Telefone",
            phoneNumberHintText: "Telefone para contato",
            phoneNumberFieldController: _phoneController,
            primaryButtonText: "Adicionar",
            secondaryButtonText: "Cancelar",
            onPrimaryButtonTapped: (dialogContext) {
              final name = _nameController.text;
              final cnpj = _cnpjController.text;
              final adress = _adressController.text;
              final email = _emailController.text;
              final phoneNumber = _phoneController.text;
              _bloc.add(
                AddCustomerEvent(
                  customer: CustomerEntity(
                    id: const Uuid().v1(),
                    name: name,
                    cnpj: cnpj,
                    adress: adress,
                    email: email,
                    phoneNumber: phoneNumber,
                  ),
                ),
              );
              dialogContext.pop();
              _clearTextFields();
              _bloc.add(GetAllCustomersEvent());
            },
            onSecondaryButtonTapped: (dialogContext) {
              dialogContext.pop();
              _clearTextFields();
            },
          );
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
