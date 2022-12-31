import 'package:flutter/material.dart';

class Pallete {
  static const Color blueColor = Color(0xFF36a3c8);
  static const Color blackColor = Color(0xFF181f24);
  static const Color grayColor = Color(0xFF252a34);
  static const Color purpleColor = Color(0xFF5567fe);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;

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
    backgroundColor: grayColor,
  );
}
