import 'package:flutter/material.dart';

enum ColorsData { normal, purple,green,brown }

abstract class ColorManager {
  Color get primary;

  Color get darkPrimary;

  Color get lightPrimary; // color with 80% opacity
  Color get background; //

  // Color get darkGrey;

  Color get grey;

  // Color get lightGrey;

  Color get fontMain;

  Color get fontLight;

  // other colors
  final Color white = const Color(0xffFFFFFF);
  final Color black = const Color(0xff000000);
  final Color error = const Color(0xff7E1428);
}

class _ColorManagerNormal extends ColorManager {
  @override
  Color primary = const Color(0xff6200eb);
  @override
  Color darkPrimary = const Color(0xff5200db);
  @override
  Color lightPrimary = const Color(0xcc6200eb); // color with 80% opacity

  @override
  Color background = const Color(0xffffffff);

  @override
  // Color darkGrey = const Color(0xff525252);
  @override
  Color grey = const Color(0xff898989);
  @override
  // Color lightGrey = const Color(0xff9E9E9E);
  @override
  // Color fontGrey = const Color(0xff5F5F5F);
  @override
  Color fontMain = const Color(0xff222222);
  @override
  Color fontLight = const Color(0xff000000);
}

class _ColorManagerPurple extends ColorManager {
  @override
  Color primary = const Color(0xffA44AFF);
  @override
  Color darkPrimary = const Color(0xff8540ee);
  @override
  Color lightPrimary = const Color(0xccA44AFF); // color with 80% opacity
  @override
  Color background = const Color(0xff283663);
  @override
  // Color darkGrey = const Color(0xff525252);
  @override
  Color grey = const Color(0xff898989);
  @override
  // Color lightGrey = const Color(0xff9E9E9E);
  @override
  // Color fontGrey = const Color(0xff5F5F5F);
  @override
  Color fontMain = const Color(0xffffffff);
  @override
  Color fontLight = const Color(0xffABAFD7);
  // Color fontLight = const Color(0xffc8c8c8);

}


class _ColorManagerGreen extends ColorManager {
  @override
  Color primary = const Color(0xff16ab43);
  @override
  Color darkPrimary = const Color(0xff489459);
  @override
  Color lightPrimary = const Color(0xcc43D765); // color with 80% opacity
  @override
  Color background = const Color(0xff366027);
  @override
  // Color darkGrey = const Color(0xff525252);
  @override
  Color grey = const Color(0xff898989);
  @override
  // Color lightGrey = const Color(0xff9E9E9E);
  @override
  // Color fontGrey = const Color(0xff5F5F5F);
  @override
  Color fontMain = const Color(0xff000000);
  @override
  Color fontLight = const Color(0xff282828);
// Color fontLight = const Color(0xffc8c8c8);

}

class _ColorManagerBrown extends ColorManager {
  @override
  Color primary = const Color(0xFF795548);
  @override
  Color darkPrimary = const Color(0xFF593E35);
  @override
  Color lightPrimary = const Color(0xFF8F5E53); // color with 80% opacity
  @override
  Color background = const Color(0x42bb9a0c);
  @override
  // Color darkGrey = const Color(0xff525252);
  @override
  Color grey = const Color(0xff898989);
  @override
  // Color lightGrey = const Color(0xff9E9E9E);
  @override
  // Color fontGrey = const Color(0xff5F5F5F);
  @override
  Color fontMain = const Color(0xff000000);
  @override
  Color fontLight = const Color(0xff282828);
// Color fontLight = const Color(0xffc8c8c8);

}

extension ColorsDataEX on ColorsData {
  ColorManager toCM() {
    switch (this) {
      case ColorsData.normal:
        return _ColorManagerNormal();
      case ColorsData.purple:
        return _ColorManagerPurple();
      case ColorsData.green:
        return _ColorManagerGreen();
      case ColorsData.brown:
        return _ColorManagerBrown();
    }
  }
}
