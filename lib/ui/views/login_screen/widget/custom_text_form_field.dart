import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/dimens.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.validator,
    this.onFieldSubmitted,
    required this.label,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens.radius8,
            ),
          ),
        ),
        labelText: label,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
