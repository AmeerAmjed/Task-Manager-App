import 'package:flutter/material.dart';
import 'package:task_manager/ui/widget/vertical_space.dart';

class Empty extends StatelessWidget {
  const Empty({
    super.key,
    required this.image,
    required this.title,
    this.description,
  });

  final Widget image;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 1),
        image,
        const VerticalSpace24(),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
        const VerticalSpace8(),
        if (description != null)
          Center(
            child: Text(
              description!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        const Spacer(flex: 2)
      ],
    );
  }
}
