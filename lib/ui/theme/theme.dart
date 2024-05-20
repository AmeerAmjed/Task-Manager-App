import 'package:flutter/material.dart';
import 'package:task_manager/ui/theme/color.dart';

part 'dark.dart';

part 'light.dart';

class ThemeApp {
  ThemeData dark = DarKThemeApp.dark();
  ThemeData light = LightThemeApp().theme();
}
