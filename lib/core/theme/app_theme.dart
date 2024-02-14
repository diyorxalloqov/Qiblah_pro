import 'package:qiblah_pro/modules/global/imports/app_imports.dart';

class AppTheme {
  ThemeData get lightMode => _ligthMode;
  ThemeData get darkMode => _darkMode;
  CupertinoThemeData get cupertinoLightMode => _cupertinoLightMode;
  CupertinoThemeData get cupertinoDarkMode => _cupertinoDarkMode;

  final CupertinoThemeData _cupertinoLightMode = CupertinoThemeData(
      brightness: Brightness.light, scaffoldBackgroundColor: scaffoldColor);

  final CupertinoThemeData _cupertinoDarkMode = CupertinoThemeData(
      brightness: Brightness.dark, scaffoldBackgroundColor: scaffoldBlackColor);

  final ThemeData _ligthMode = ThemeData(
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(backgroundColor: primaryColor)),
      brightness: Brightness.light,
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: bottomNavbarColor),
      scaffoldBackgroundColor: scaffoldColor,
      cardColor: cardColor,
      bottomAppBarTheme: BottomAppBarTheme(color: bottomAppbarColor),
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
      )

      // appBarTheme: AppBarTheme(
      //     actionsIconTheme: const IconThemeData(color: Colors.black),
      //     backgroundColor: Colors.white.withOpacity(0.1),
      //     titleTextStyle: const TextStyle(
      //         fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
      // textTheme: const TextTheme(
      //   displaySmall: TextStyle(color: Colors.black),
      //   displayLarge: TextStyle(color: Color.fromRGBO(96, 125, 139, 1)),
      //   bodyLarge: TextStyle(color: Colors.black),
      // ),
      );

  final ThemeData _darkMode = ThemeData(
      brightness: Brightness.dark,
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
      // appBarTheme: AppBarTheme(
      //     actionsIconTheme: const IconThemeData(color: Colors.white),
      //     backgroundColor: Colors.blueGrey.shade900.withOpacity(0.8),
      //     titleTextStyle: const TextStyle(
      //         color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
      // textTheme: TextTheme(
      //     displaySmall: const TextStyle(color: Colors.white),
      //     displayLarge: TextStyle(color: Colors.white70.withOpacity(0.7)),
      //     bodyLarge: const TextStyle(color: Colors.white))
      );
}
