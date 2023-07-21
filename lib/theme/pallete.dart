import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/enums/app_theme_mode.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  static const Color blueColor = Color(0xFF36a3c8);
  static const Color blackColor = Color(0xFF1c1d22);
  static const Color grayColor = Color(0xFF25262e);
  static const Color purpleColor = Color(0xFF5567fe);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color green = Color(0xFF42ca91);
  static const Color darkGreen = Color(0xFF234037);
  static const Color yellow = Color(0xFFc8b162);
  static const Color darkYellow = Color(0xFF3c3a2f);
  static const Color red = Color(0xFFdf696a);
  static const  Color darkRed = Color(0xFF432c30);
  static const Color orange = Color(0xFFf8961e);
  static const Color darkOrange = Color(0xFF3c2f1e);




  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: grayColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: grayColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: grayColor,
    ),
    primaryColor: whiteColor,
    // ignore: deprecated_member_use
    backgroundColor: grayColor,
  );

  static const backgroundColor = Color(0xFFf8f8f8);
  static const darkGrayColor = Color(0xFFe8eeee);
  static const componetColor = Color(0xFFdfdfdf);

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: backgroundColor,
    cardColor: whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: blackColor,
    // ignore: deprecated_member_use
    backgroundColor: whiteColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
      ),
    ),
   
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  AppThemeMode _mode;
  ThemeNotifier({AppThemeMode mode = AppThemeMode.dark})
      : _mode = mode,
        super(
          Pallete.lightModeAppTheme,
        ) {
    getTheme();
  }

  AppThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = AppThemeMode.light;
      state = Pallete.lightModeAppTheme;
    } else {
      _mode = AppThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = AppThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = AppThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
