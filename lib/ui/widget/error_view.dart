import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.message,
    required this.onPressed,
  });

  final String message;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text(message)),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.cached_rounded),
        )
      ],
    );
  }
}
