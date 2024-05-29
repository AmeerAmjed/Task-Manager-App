import 'package:flutter/material.dart';
import 'package:task_manager/ui/theme/color.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/utils/horizontal_space.dart';

bottomSheet({
  required BuildContext context,
  required List<Widget> children,
  double height = 250.0,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(Dimens.radius16),
        topLeft: Radius.circular(Dimens.radius16),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        height: height,
        margin: EdgeInsets.only(
          right: Dimens.spacing16,
          left: Dimens.spacing16,
          bottom: (MediaQuery.of(context).viewInsets.bottom - 50.0)
              .abs()
              .toDouble(),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _DividerBottomSheet(),
            ...children,
          ],
        ),
      );
    },
  );
}

class _DividerBottomSheet extends StatelessWidget {
  const _DividerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.2,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Dimens.spacing12,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: ColorSystem().dividerBottomSheet,
            borderRadius: const BorderRadius.all(
              Radius.circular(2.5),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonActionBottomSheet extends StatelessWidget {
  const ButtonActionBottomSheet({
    super.key,
    required this.title,
    this.icon,
    this.color,
    this.paddingVertical = Dimens.spacing16,
    required this.onPressed,
  });

  final String title;
  final IconData? icon;
  final double paddingVertical;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.spacing16,
          vertical: paddingVertical,
        ),
        shape: const RoundedRectangleBorder(),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            color: color ??
                Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
          ),
          const HorizontalSpace8(),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: color,
                ),
          )
        ],
      ),
    );
  }
}
