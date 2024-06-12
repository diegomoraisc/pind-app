import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pind_app/src/common/constants/app_text_styles.dart';

class CustomerCard extends StatelessWidget {
  final String name;
  final String adress;
  final void Function(BuildContext) onEdit;
  final void Function(BuildContext) onRemove;
  final void Function()? onLongPress;
  const CustomerCard({
    Key? key,
    required this.name,
    required this.adress,
    required this.onEdit,
    required this.onRemove,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(12);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 20,
        left: 20,
      ),
      child: Card(
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned.fill(
              child: Builder(
                builder: (context) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: borderRadius,
                  ),
                ),
              ),
            ),
            Slidable(
              key: UniqueKey(),
              direction: Axis.horizontal,
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: onEdit,
                    icon: Icons.edit,
                    foregroundColor: Colors.grey,
                    backgroundColor: Colors.transparent,
                  ),
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    onPressed: onRemove,
                    icon: Icons.delete,
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: borderRadius,
                ),
                child: Center(
                  child: ListTile(
                    onLongPress: onLongPress,
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      name,
                      style: AppTextStyles.semiBold20.apply(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    subtitle: Text(
                      adress,
                      style: AppTextStyles.medium14,
                    ),
                    trailing: Icon(
                      Icons.info_rounded,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
