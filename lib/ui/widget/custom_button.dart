import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/dimens.dart';
import 'package:task_manager/ui/widget/loading_indicator.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
  });

  final Widget child;
  final bool isLoading;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.heightButton,
      margin: const EdgeInsets.symmetric(
        vertical: Dimens.spacing16,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimens.radius8,
                ),
              ),
            ),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading ? const LoadingIndicator() : child,
      ),
    );
  }
}
