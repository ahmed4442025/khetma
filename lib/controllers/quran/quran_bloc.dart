import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/presentation/resources/font_manager.dart';
import 'package:khetma/presentation/resources/styles_manager.dart';
import 'package:meta/meta.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

part 'quran_event.dart';

part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  static QuranBloc get(context) => BlocProvider.of(context);

  QuranBloc() : super(QuranInitial());

  void init() {
    _sliderSpeedValue = _sliderSpeedMinValue;
    _speedSlider = 0;
    _sliderFontValue = fontValue;
  }

  // ------------ slider speed -------------
  late double _sliderSpeedValue;
  late double _speedSlider;
  int maxIndex = 0;
  final double _sliderSpeedMaxValue = .00007;
  final double _sliderSpeedMinValue = .0000;
  Map<int, int> _mapKeys = {};

  // getter
  double get sliderSpeedMaxValue => _sliderSpeedMaxValue;

  double get sliderSpeedValue => _sliderSpeedValue;

  double get sliderSpeedMinValue => _sliderSpeedMinValue;

  int indexOfAya(int surahId, int ayaId) {
    int key = surahId * 1000 + ayaId;
    if (!_mapKeys.containsKey(key)) {
      _mapKeys[key] = ++maxIndex;
    }
    return _mapKeys[key] ?? -1;
  }

  void resetMapKey() => _mapKeys = {};

  void changeSliderSpeedValue(double sliderNewValue) {
    _sliderSpeedValue = sliderNewValue;
    emit(QSSlider());
  }

  void changeSpeed(double newSliderValue) {
    _speedSlider = newSliderValue;
    emit(QSSpeedSlider());
  }

  Duration? timeToScroll(AutoScrollController controller) {
    print(_speedSlider);
    if (_speedSlider <= _sliderSpeedMaxValue / 30) return null;
    double diff = controller.position.maxScrollExtent - controller.offset;
    int mSec = diff ~/ _speedSlider;
    return Duration(microseconds: mSec);
  }

  // ------------ slider font -------------
  late double _sliderFontValue;
  final double _sliderFontMaxValue = 48;
  final double _sliderFontMinValue = 16;
  double fontValue = 24;

  // getter
  double get sliderFontValue => _sliderFontValue;

  double get sliderFontMaxValue => _sliderFontMaxValue;

  double get sliderFontMinValue => _sliderFontMinValue;

  // double get fontValue => _fontValue;

  void changeFontValue(double newValue) {
    _sliderFontValue = newValue;
    emit(QSSliderFontChange());
  }

  void endChangeFontValue(double newValue) {
    fontValue = newValue;
    print("change font");
    emit(QSSliderFontEndChange());
  }

  // ------------ font family -------------
  String fontFamily = FontConstant.fontHafss;

  void changeFamilyFont(String newFont) {
    fontFamily = newFont;
    emit(QSFontFamily());
  }

  TextStyle quranStyle() => StylesManager.quranTextStyle(fontValue, fontFamily);

  // main
  void changeSearch() {
    emit(QSMainSearch());
  }
}
