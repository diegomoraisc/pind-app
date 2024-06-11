import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/common/widgets/custom_progress_indicator.dart';
import 'package:pind_app/src/features/customers/interactor/blocs/client_bloc.dart';
import 'package:pind_app/src/features/customers/interactor/entities/client_entity.dart';
import 'package:pind_app/src/features/customers/interactor/events/client_event.dart';
import 'package:pind_app/src/features/customers/interactor/states/client_state.dart';
import 'package:pind_app/src/features/customers/ui/widgets/client_card.dart';
import 'package:pind_app/src/features/customers/ui/widgets/client_form_dialog.dart';
import 'package:pind_app/src/features/customers/ui/widgets/client_info_dialog.dart';
import 'package:uuid/uuid.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final _bloc = getIt.get<ClientBloc>();
  final _nameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _adressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllClientsEvent());
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

  void _showClientInfo(BuildContext context, {required ClientEntity client}) {
    showDialog(
      context: context,
      builder: (builder) => ClientInfoDialog(
        title: client.name,
        clientName: client.name,
        cnpj: client.cnpj,
        clientAdress: client.adress,
        clientEmail: client.email,
        clientPhoneNumber: client.phoneNumber,
      ),
    );
  }

  void _addOrEditClient(BuildContext context, {String? clientId}) {
    showDialog(
      context: context,
      builder: (context) => ClientFormDialog(
        title: clientId == null
            ? "Adicionar novo cliente"
            : "Editar informações de um cliente",
        clientName: "Nome",
        nameHintText: "Nome do cliente",
        clientNameFieldController: _nameController,
        cnpj: "CNPJ",
        cnpjHintText: "CNPJ do cliente",
        cnpjFieldController: _cnpjController,
        clientAdress: "Endereço",
        adressHintText: "Endereço do cliente",
        adressFieldController: _adressController,
        clientEmail: "Email",
        emailHintText: "Email do cliente",
        emailFieldController: _emailController,
        clientPhoneNumber: "Telefone",
        phoneNumberHintText: "Telefone para contato",
        phoneNumberFieldController: _phoneController,
        primaryButtonText: clientId == null ? "Adicionar" : "Editar",
        secondaryButtonText: "Cancelar",
        onPrimaryButtonTapped: () {
          final name = _nameController.text;
          final cnpj = _cnpjController.text;
          final adress = _adressController.text;
          final email = _emailController.text;
          final phoneNumber = _phoneController.text;
          if (clientId != null) {
            _bloc.add(
              UpdateClientEvent(
                id: clientId,
                updatedClient: ClientEntity(
                  id: clientId,
                  name: name,
                  cnpj: cnpj,
                  adress: adress,
                  email: email,
                  phoneNumber: phoneNumber,
                ),
              ),
            );
          } else {
            _bloc.add(
              AddClientEvent(
                client: ClientEntity(
                  id: const Uuid().v1(),
                  name: name,
                  cnpj: cnpj,
                  adress: adress,
                  email: email,
                  phoneNumber: phoneNumber,
                ),
              ),
            );
          }
          context.pop();
          _clearTextFields();
          _bloc.add(GetAllClientsEvent());
        },
        onSecondaryButtonTapped: () {
          context.pop();
          _clearTextFields();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocBuilder<ClientBloc, ClientState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is LoadingClientState) {
            return Center(
              child: CustomProgressIndicator(
                color: theme.colorScheme.tertiary,
              ),
            );
          } else if (state is LoadedClientState) {
            return ListView.builder(
              itemCount: state.clients.length,
              itemBuilder: (context, index) {
                final client = state.clients[index];
                return ClientCard(
                  name: client.name,
                  adress: client.adress,
                  onLongPress: () => _showClientInfo(context, client: client),
                  onEdit: (context) {
                    _nameController.text = client.name;
                    _cnpjController.text = client.cnpj;
                    _adressController.text = client.adress;
                    _emailController.text = client.email;
                    _phoneController.text = client.phoneNumber;
                    _addOrEditClient(context, clientId: client.id);
                  },
                  onRemove: (context) {
                    _bloc.add(RemoveClientEvent(id: client.id!));
                    _bloc.add(GetAllClientsEvent());
                  },
                );
              },
            );
          } else if (state is ErrorClientState) {
            final message = state.message;
            return Center(
              child: Text(
                message,
                style: AppTextStyles.medium14,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditClient(context),
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
