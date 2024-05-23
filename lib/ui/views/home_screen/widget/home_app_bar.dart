import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/model/user_model.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/ui/views/home_screen/bloc/home_screen_bloc.dart';
import 'package:task_manager/ui/views/home_screen/widget/Image_network.dart';
import 'package:task_manager/utils/horizontal_space.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.onClickSavedAction,
  });

  final Function() onClickSavedAction;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (BuildContext context, state) {
              if (state is SucceedGetUserInfoState) {
                if (context.read<HomeScreenBloc>().user != null) {
                  return Row(
                    children: [
                      ImageNetwork(
                        imageUrl: context.read<HomeScreenBloc>().user!.avatar,
                        borderRadius: BorderRadius.circular(Dimens.spacing8),
                        size: 35,
                      ),
                      const HorizontalSpace8(),
                      Text(
                        context.read<HomeScreenBloc>().user!.firstName,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      )
                    ],
                  );
                }
              }

              return const SizedBox();
            },
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onClickSavedAction,
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          icon: const Icon(
            Icons.bookmark,
          ),
        ),
        const HorizontalSpace16(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
