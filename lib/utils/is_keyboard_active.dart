import 'package:flutter/cupertino.dart';

extension KeyboardDetection on BuildContext {
  bool isKeyboardActive() => MediaQuery.of(this).viewInsets.bottom == 0.0;
}
