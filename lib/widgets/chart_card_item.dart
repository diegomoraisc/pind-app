import 'package:flutter/material.dart';

class ChartCardItem extends StatelessWidget {
  final String name;
  final String percentage;
  const ChartCardItem({
    super.key,
    required this.name,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        bottom: 20,
        left: 15,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        elevation: 3,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Align(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.purple,
                radius: 5,
              ),
              title: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(color: Theme.of(context).colorScheme.primary),
              ),
              trailing: Text(
                percentage,
                style: Theme.of(context).textTheme.titleSmall!.apply(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
