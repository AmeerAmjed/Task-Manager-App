part of 'theme.dart';

class LightThemeApp extends ColorSystem {
  ThemeData theme() {
    return ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          background: lightBackground,
          onBackground: lightOnBackground,
          primary: lightPrimary,
          onPrimary: lightOnPrimary,
          secondary: lightSecondary,
          onSecondary: lightOnSecondary,
          error: lightError,
          onError: lightOnError,
          surface: lightSurface,
          onSurface: lightOnSurface,
        ),
        checkboxTheme: const CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ));
  }
}
