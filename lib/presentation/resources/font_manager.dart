import 'package:flutter/material.dart';

enum FontFamilyData { uthmani, uthmani2, amiri, hafss }

class FontConstant {
  static const fontMontserrat = "Montserrat";
  static const fontUthmani = "uthmani";
  static const fontUthmani2 = "uthmani2";
  static const fontAmiri = "amiri";
  static const fontHafss = "hafss";
  static const fontsurah3 = "surah3";
  static const fontJoz2 = "joz2";
}

class FontWeightManager {
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight light = FontWeight.w300;
}

class FontSizeManager {
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s17 = 17;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s26 = 26;
  static const double s28 = 28;
  static const double s30 = 30;

  static const double disLarge = 64;
}

extension FontData on FontFamilyData {
  String toText() {
    switch (this) {
      case FontFamilyData.uthmani:
        return FontConstant.fontUthmani;
      case FontFamilyData.uthmani2:
        return FontConstant.fontUthmani2;
      case FontFamilyData.amiri:
        return FontConstant.fontAmiri;
      case FontFamilyData.hafss:
        return FontConstant.fontHafss;
    }
  }
}
