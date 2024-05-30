part of 'theme.dart';

class DarkThemeApp extends ColorSystem {
  ThemeData theme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      fontFamily: GoogleFonts.urbanist().fontFamily,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        background: darkBackground,
        onBackground: darkOnBackground,
        primary: darkPrimary,
        onPrimary: darkOnPrimary,
        secondary: darkSecondary,
        onSecondary: darkOnSecondary,
        error: darkError,
        onError: darkOnError,
        surface: darkSurface,
        onSurface: darkOnSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackground,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: darkBackground,
          statusBarColor: darkBackground,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      checkboxTheme: const CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: Dimens.fontSize20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
