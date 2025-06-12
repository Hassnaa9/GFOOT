import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

class AppThemes {
  static const TextTheme _commonTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
    headlineMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Urbanist',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: MyColors.kPrimaryColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: MyColors.kPrimaryColor,
        fontFamily: 'Urbanist',
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyColors.kPrimaryColor,
      brightness: Brightness.light,
      primary: MyColors.kPrimaryColor,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black87,
      background: Colors.white,
      onBackground: Colors.black87,
      error: Colors.red,
      onError: Colors.white,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: MyColors.kPrimaryColor,
      textColor: Colors.black87,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) =>
          states.contains(MaterialState.selected) ? const Color(0xff008B6B) : Colors.grey),
      trackColor: MaterialStateProperty.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? MyColors.kPrimaryColor
              : Colors.grey.withOpacity(0.5)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MyColors.kPrimaryColor,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: _commonTextTheme.apply(bodyColor: Colors.black87, displayColor: Colors.black87),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xffE8ECF4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: BorderSide.none,
      ),
    ),
    dividerTheme: const DividerThemeData(color: Colors.grey, thickness: 1),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: MyColors.kPrimaryColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Urbanist',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Urbanist',
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyColors.kPrimaryColor,
      brightness: Brightness.dark,
      primary: MyColors.kPrimaryColor,
      onPrimary: Colors.white,
      secondary: const Color(0xFF424242),
      onSecondary: Colors.white,
      surface: const Color(0xFF1E1E1E),
      onSurface: Colors.white,
      background: const Color(0xFF121212),
      onBackground: Colors.white,
      error: const Color(0xFFCF6679),
      onError: Colors.black,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: MyColors.kPrimaryColor,
      textColor: Colors.white,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) =>
          states.contains(MaterialState.selected) ? const Color(0xff4CAF50) : Colors.grey[700]),
      trackColor: MaterialStateProperty.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? const Color(0xff4CAF50).withOpacity(0.5)
              : Colors.grey.withOpacity(0.5)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MyColors.kPrimaryColor,
      unselectedItemColor: Colors.grey[500],
    ),
    textTheme: _commonTextTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: BorderSide.none,
      ),
    ),
    dividerTheme: DividerThemeData(color: Colors.grey[700], thickness: 1),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: MyColors.kPrimaryColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    ),
  );
}