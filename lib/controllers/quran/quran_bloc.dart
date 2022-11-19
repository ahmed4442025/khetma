import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/app/app_constants.dart';
import 'package:khetma/presentation/resources/font_manager.dart';
import 'package:khetma/presentation/resources/styles_manager.dart';
import 'package:meta/meta.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../domain/repository/cache_repository.dart';
import '../../presentation/views/quran/not_view/mini_settings.dart';

part 'quran_event.dart';

part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  static QuranBloc get(context) => BlocProvider.of(context);
  final CacheRepository _cacheRepository;

  QuranBloc(this._cacheRepository) : super(QuranInitial());

  Future init() async {
    await _loadCache();
    _sliderSpeedValue = _sliderSpeedMinValue;
    _speedSlider = 0;
    _sliderFontValue = fontValue;
  }

  // font family list (settings)
  List<FontModel> fontList = [
    FontModel(FontConstant.fontUthmani2, "عثماني"),
    FontModel(FontConstant.fontHafss, "حفص"),
    FontModel(FontConstant.fontAmiri, "اميري"),
    FontModel(FontConstant.fontUthmani, "اميري2"),
  ];

  // ------------ slider speed -------------
  late double _sliderSpeedValue;
  late double _speedSlider;
  final double _sliderSpeedMaxValue = .00007;
  final double _sliderSpeedMinValue = .0000;


  // getter
  double get sliderSpeedMaxValue => _sliderSpeedMaxValue;

  double get sliderSpeedValue => _sliderSpeedValue;

  double get sliderSpeedMinValue => _sliderSpeedMinValue;





  void changeSliderSpeedValue(double sliderNewValue) {
    _sliderSpeedValue = sliderNewValue;
    emit(QSSlider());
  }

  void changeSpeed(double newSliderValue) {
    _speedSlider = newSliderValue;
    emit(QSSpeedSlider());
  }

  Duration? timeToScroll(AutoScrollController controller) {
    if (_speedSlider <= _sliderSpeedMaxValue / 30) return null;
    double diff = controller.position.maxScrollExtent - controller.offset;
    int mSec = diff ~/ _speedSlider;
    return Duration(microseconds: mSec);
  }

  // ------------ slider font -------------
  late double _sliderFontValue;
  final double _sliderFontMaxValue = AppConstants.fontMaxValue;
  final double _sliderFontMinValue = AppConstants.fontMinValue;
  late double fontValue ;

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
    _setFontSizeCache(newValue);
    emit(QSSliderFontEndChange());
  }

  // ------------ font family -------------
  String fontFamily = AppConstants.defaultFontFamily;

  // change font family
  void changeFamilyFont(String newFont) {
    fontFamily = newFont;
    _setFontFamilyCache(newFont);
    emit(QSFontFamily());
  }

  TextStyle quranStyle() => StylesManager.quranTextStyle(fontValue, fontFamily);

  // main
  void changeSearch() {
    emit(QSMainSearch());
  }

  // cache font
  // get all
  Future _loadCache() async {
    fontValue = await _cacheRepository
        .getFontSize()
        .fold((l) => AppConstants.defaultFontSize, (r) => r);
    fontFamily = await _cacheRepository
        .getFontFamily()
        .fold((l) => AppConstants.defaultFontFamily, (r) => r);
  }
  // set size
  Future _setFontSizeCache(double size) async {
    await _cacheRepository.setFontSize(size);
  }
  // set family
  Future _setFontFamilyCache(String family) async {
    await _cacheRepository.setFontFamily(family);
  }
}
