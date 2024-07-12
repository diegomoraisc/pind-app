import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:pind_app/src/features/auth/interactor/events/auth_event.dart';
import 'package:pind_app/src/common/utils/locator.dart';
import 'package:pind_app/src/common/widgets/custom_circle_avatar.dart';
import 'package:pind_app/src/common/widgets/custom_list_tile.dart';
import 'package:pind_app/src/common/widgets/primary_button.dart';
import 'package:pind_app/src/features/profile/ui/widgets/image_picker_modal.dart';
import 'package:pind_app/src/features/profile/ui/widgets/image_picker_modal_item.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String email;
  const ProfilePage({
    super.key,
    required this.userName,
    required this.email,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthBloc bloc = getIt<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CustomCircleAvatar(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => ImagePickerModal(
                        children: [
                          ImagePickerModalItem(
                            title: "Galeria",
                            icon: Icons.image_rounded,
                            onPressed: () {},
                          ),
                          ImagePickerModalItem(
                            title: "Camera",
                            icon: Icons.camera_alt_rounded,
                            onPressed: () {},
                          ),
                          ImagePickerModalItem(
                            title: "Remover",
                            icon: Icons.restore_from_trash_rounded,
                            iconColor: Colors.red,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Text(
                widget.userName,
                style: theme.textTheme.titleLarge!.apply(color: Colors.black),
              ),
              Text(
                widget.email,
                style: theme.textTheme.titleSmall,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  children: [
                    CustomListTile(
                      title: "Configurações",
                      leadingIcon: Icons.settings_outlined,
                      onPressed: () {},
                    ),
                    CustomListTile(
                      title: "Suporte",
                      leadingIcon: Icons.info_outline,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            child: PrimaryButton(
              width: MediaQuery.of(context).size.width,
              height: 50,
              textColor: Colors.white,
              backgroundColor: theme.colorScheme.error,
              text: "Sair",
              onPressed: () {
                bloc.add(LogoutAuthEvent());
                context.go('/');
              },
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
