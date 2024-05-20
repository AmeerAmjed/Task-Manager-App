import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/assets.dart';
import 'package:task_manager/ui/utils/dimens.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: Dimens.spacing8),
            child: Image(
              image: AssetImage(Assets.logo),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Taski",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
