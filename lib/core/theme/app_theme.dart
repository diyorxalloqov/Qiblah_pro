import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class AppTheme {
  ThemeData get lightMode => _ligthMode;
  ThemeData get darkMode => _darkMode;
  CupertinoThemeData get cupertinoLightMode => _cupertinoLightMode;
  CupertinoThemeData get cupertinoDarkMode => _cupertinoDarkMode;

  final CupertinoThemeData _cupertinoLightMode = CupertinoThemeData(
      applyThemeToAll: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: scaffoldColor);

  final CupertinoThemeData _cupertinoDarkMode = CupertinoThemeData(
      applyThemeToAll: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: scaffoldBlackColor);

  final ThemeData _ligthMode = ThemeData(
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(backgroundColor: primaryColor)),
      brightness: Brightness.light,
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: bottomNavbarColor),
      scaffoldBackgroundColor: scaffoldColor,
      cardColor: cardColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      bottomAppBarTheme: BottomAppBarTheme(color: bottomAppbarColor),
      appBarTheme: AppBarTheme(backgroundColor: appBarColor)

      // textTheme: const TextTheme(
      //   displaySmall: TextStyle(color: Colors.black),
      //   displayLarge: TextStyle(color: Color.fromRGBO(96, 125, 139, 1)),
      //   bodyLarge: TextStyle(color: Colors.black),
      // ),
      );

  final ThemeData _darkMode = ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      bottomAppBarTheme: BottomAppBarTheme(color: bottomAppbarBlackColor),
      cardColor: cardBlackColor,
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: bottomNavbarBlackColor),
      appBarTheme: AppBarTheme(backgroundColor: appBarBlackColor),
      scaffoldBackgroundColor: scaffoldBlackColor
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //         backgroundColor: Colors.blueGrey.shade800)),
      // scaffoldBackgroundColor: Colors.blueGrey.shade900,
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   backgroundColor: Colors.blueGrey.shade900,
      // ),
      // bottomSheetTheme: BottomSheetThemeData(
      //   backgroundColor: Colors.blueGrey.shade900,
      // ),
      // textTheme: TextTheme(
      //     displaySmall: const TextStyle(color: Colors.white),
      //     displayLarge: TextStyle(color: Colors.white70.withOpacity(0.7)),
      //     bodyLarge: const TextStyle(color: Colors.white))
      );
}
