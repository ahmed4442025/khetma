import 'font_manager.dart';
import 'package:flutter/material.dart';

class StylesManager {
  static TextStyle _getTextStyle(
      double? fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: FontConstant.fontMontserrat);
  }

  static TextStyle quranTextStyle(double size, String fontFamily) {
    final ss = TextStyle(
        color: Colors.black,
        fontFamily: fontFamily,
        fontSize: size);
    return ss;
  }

  // regular style
  static getRegularStyle(
      {double fontSize = FontSizeManager.s12, required color}) {
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }

  // medium style
  static getMediumStyle(
      {double fontSize = FontSizeManager.s12, required color}) {
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }

  // bold style
  static bold({double? fontSize, required color}) {
    return _getTextStyle(fontSize, FontWeightManager.bold, color);
  }

  // light style
  static getLightStyle(
      {double fontSize = FontSizeManager.s12, required color}) {
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  } // semiBold style

  static getSemiBoldStyle(
      {double fontSize = FontSizeManager.s12, required color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }
}
