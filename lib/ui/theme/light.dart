part of 'theme.dart';

class LightThemeApp extends ColorSystem {
  ThemeData theme() {
    return ThemeData(
        brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: GoogleFonts.urbanist().fontFamily,
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
      appBarTheme: AppBarTheme(
          backgroundColor: lightBackground,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: lightBackground,
            statusBarColor: lightBackground,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
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
