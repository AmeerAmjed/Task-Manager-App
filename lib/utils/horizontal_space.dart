import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/dimens.dart';

class HorizontalSpace4 extends StatelessWidget {
  const HorizontalSpace4({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: Dimens.spacing4,
    );
  }
}

class HorizontalSpace8 extends StatelessWidget {
  const HorizontalSpace8({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: Dimens.spacing8,
    );
  }
}

class HorizontalSpace16 extends StatelessWidget {
  const HorizontalSpace16({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: Dimens.spacing16,
    );
  }
}
