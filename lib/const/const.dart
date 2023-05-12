import 'package:flutter/material.dart';

class Const {
  static const Color mainBlueColor = Color(_bluePrimaryValue);
  static const int _bluePrimaryValue = 0xFF2196F3;

  static const MaterialColor mainBlueColorSwatch = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: mainBlueColor,
      100: mainBlueColor,
      200: mainBlueColor,
      300: mainBlueColor,
      400: mainBlueColor,
      500: mainBlueColor,
      600: mainBlueColor,
      700: mainBlueColor,
      800: mainBlueColor,
      900: mainBlueColor,
    },
  );
}
