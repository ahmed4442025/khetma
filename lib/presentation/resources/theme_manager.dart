import 'dart:async';

import 'font_manager.dart';

import 'styles_manager.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';
import 'color_manager.dart';

class ThemeManager {
  // stream controller for App MaterialApp
  static final StreamController _colorManagerSC =
      StreamController<bool>.broadcast();

  // input
  static final Sink _inputColorMangerSC = _colorManagerSC.sink;

  // output
  static Stream<bool> get outThemeChanged =>
      _colorManagerSC.stream.map((event) => true);

  // current theme data
  static ThemeData currentThem = _normalThemeManager.getAppTheme();

  // current color
  static ColorManager c = ColorsData.normal.toCM();

  // default
  static final NormalThemeManager _normalThemeManager = NormalThemeManager(c);

  static changeColor(ColorsData colorsData) {
    c = colorsData.toCM();
    _normalThemeManager.fromColorManager(c);
    _inputColorMangerSC.add(true);
  }
}

class NormalThemeManager {
  ColorManager _cM;

  NormalThemeManager(this._cM);

  void fromColorManager(ColorManager colorManager) {
    _cM = colorManager;
  }

  ThemeData getAppTheme() {
    return ThemeData(
      // main colors
      primaryColor: _cM.primary,
      primaryColorLight: _cM.lightPrimary,
      primaryColorDark: _cM.darkPrimary,
      disabledColor: _cM.grey,
      splashColor: _cM.lightPrimary,
      scaffoldBackgroundColor: _cM.background,

      // app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: false,
          color: _cM.primary,
          elevation: AppSize.s4,
          shadowColor: _cM.lightPrimary,
          titleTextStyle: StylesManager.getRegularStyle(
              fontSize: FontSizeManager.s16, color: _cM.white)),

      // button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: _cM.grey,
          buttonColor: _cM.primary,
          splashColor: _cM.lightPrimary),

      // elevated button them
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: StylesManager.getRegularStyle(
                  color: _cM.white, fontSize: FontSizeManager.s17),
              backgroundColor: _cM.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      // text theme
      textTheme: TextTheme(
        // bodySmall: StylesManager.getRegularStyle(
        //     color: _cM.fontMain, fontSize: FontSizeManager.s14),
        //
        // labelMedium: StylesManager.getRegularStyle(
        //     color: _cM.fontMain, fontSize: FontSizeManager.s20),
        // labelSmall: StylesManager.getRegularStyle(
        //     color: _cM.fontMain, fontSize: FontSizeManager.s20),
        bodyMedium: StylesManager.getRegularStyle(
            color: _cM.fontMain, fontSize: FontSizeManager.s14),
        bodyLarge: StylesManager.getRegularStyle(
            color: _cM.fontMain, fontSize: FontSizeManager.s20),
        // ----------- text field -----------
        titleMedium: StylesManager.getMediumStyle(
            color: _cM.fontMain, fontSize: FontSizeManager.s14),
      ),
      // input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
          // content padding
          contentPadding: const EdgeInsets.all(AppPadding.p8),
          // hint style
          hintStyle: StylesManager.getRegularStyle(
              color: _cM.fontLight, fontSize: FontSizeManager.s14),
          labelStyle: StylesManager.getMediumStyle(
              color: _cM.fontLight, fontSize: FontSizeManager.s14),
          errorStyle: StylesManager.getRegularStyle(color: _cM.error),

          // enabled border style
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _cM.grey, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),

          // focused border style
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _cM.primary, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),

          // error border style
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _cM.error, width: AppSize.s2),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),
          errorMaxLines: 2,
          // focused border style
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _cM.primary, width: AppSize.s2),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8)))),
    );
  }
}
