import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/ui/theme/color.dart';
import 'package:task_manager/ui/utils/dimens.dart';

part 'dark.dart';
part 'light.dart';

class ThemeApp {
  ThemeData dark = DarkThemeApp().theme();
  ThemeData light = LightThemeApp().theme();
}
