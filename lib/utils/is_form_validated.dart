import 'package:flutter/material.dart';

extension FormValidate on GlobalKey<FormState> {
  bool isFormValidated() => currentState!.validate();
}
