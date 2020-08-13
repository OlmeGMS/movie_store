import 'package:flutter/material.dart';

enum APPTheme { AppLight, AppDark }

final appThemeData = {
  APPTheme.AppLight:
      ThemeData(brightness: Brightness.light, primaryColor: Colors.green),
  APPTheme.AppDark: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color.fromRGBO(2, 24, 41, 0.9)),
};
